-- REFERENCE: ------------------------------------------------------------------
-- vim.lsp.util.trim_empty_lines (only begin & end!)
-- vim.lsp.util.try_trim_markdown_code_blocks
--
local api = vim.api
local neorocks = require("plenary.neorocks")

neorocks.setup_paths() -- NOTE: environment variable SHELL *must not* be set to fish
-- neorocks.install('moses')
local _ = require 'moses'

local M = {}

-- Priting & logging -----------------------------------------------------------

function M.p(s) -- {{{
    print(vim.inspect(s))
end -- }}}

function M.printEach(range, label) -- {{{
    label = label .. ': ' or ''
    for _, v in pairs(range) do
        print(label, v)
    end
end -- }}}

function M.look() -- {{{
    local line = split(vim.fn.getline('.'), ' ')

    local api_method = line[1]
    if #line > 1 then
        local arg = line[2]
        print(vim.inspect(vim.api[api_method](arg)))
    else
        print(vim.inspect(vim.api[api_method]()))
    end
end -- }}}

-- String utils ----------------------------------------------------------------

function M.startswith(str, prefix) -- {{{
    return string.sub(str, 1, #prefix) == prefix
end -- }}}

function M.stringSplit(str, sep, max) -- {{{
    sep = '^(.-)' .. sep
    local t, n, p, q, r, s = {}, 1, 1, str:find(sep)
    while q and n ~= max do
        t[n], n, p = s, n + 1, r + 1
        q, r, s = str:find(sep, p)
    end
    t[n] = str:sub(p)
    return t
end -- }}}

function M.trim(s) -- {{{
    local from = s:match "^%s*()"
    return from > #s and "" or s:match(".*%S", from)
end -- }}}

function M.escapePattern(text) -- {{{
    return text:gsub("([^%w])", "%%%1")
end -- }}}

-- Line utils ------------------------------------------------------------------

function M.lineIsCommented(line) -- {{{
    line = line or vim.fn.getline('.')
    local cms = vim.bo.commentstring:gsub('%%s', '') -- '%%' matches literal %
    -- Careful! 
    --    (, ), ., +, -, *, ?, [, ], ^, $, and % are special pattern chars
    --    % is only special char in replace pattern
    return _.toBoolean(line:match('^%s*' .. M.escapePattern(cms)))
end -- }}}

function M.getRange(startline, endline, opts) -- {{{
    opts = opts or {}
    startline = startline or 1
    endline = endline or vim.fn.line('$')
    local bufnr = opts.bufnr or 0

    local lines = vim.api.nvim_buf_get_lines(bufnr, startline, endline, false)

    if opts.noEmpty then
        lines = _.reject(lines, _.isEmpty)
    end
    if opts.trim then
        lines = _.map(lines, _.M.trim)
    end

    return lines
end -- }}}

function M.getLine(ln) -- {{{
    return vim.fn.getline(ln)
end -- }}}

function M.isBlank(ln) -- {{{
    local line = (type(ln) == 'number') and M.getLine(ln) or ln
    return _.isEmpty(line)
end -- }}}

-- Buffer utils ----------------------------------------------------------------

function M.getBufVar(varname, bufNr) -- {{{
    -- get buffer var safely, without error if var isn't set
    bufNr = bufNr or 0
    local ok, foldedLines = pcall(function()
        return vim.api.nvim_buf_get_var(bufNr, varname)
    end)
end -- }}}

-- Experiments -----------------------------------------------------------------

function M.makeScratch() -- {{{
    api.nvim_command('enew') -- equivalent to :enew
    print(vim.bo)
    vim.bo[0].bufhidden = hide
    vim.bo[0].swapfile = false
end -- }}}

function M.create_fold(first, last) -- {{{
    vim.api.nvim_command(string.format("%d,%dfold", first, last))
end -- }}}

return M
