-- local neorocks = require("plenary.neorocks")
-- neorocks.setup_paths() -- NOTE: environment variable SHELL *must not* be set to fish
-- neorocks.install('moses')
local _ = require 'moses'
local u = require 'utils'

local M = {}

function M.lineStartsFold(line) -- {{{
    line = line or vim.fn.getline('.')
    local fmr_pattern = u.stringSplit(vim.wo.foldmarker, ',')
    -- ❯ table with 2 elements {'{{{', '}}}'}. We just want the 1st

    local hasFold = line:match(u.escapePattern(fmr_pattern[1]))
    -- print(vim.inspect(hasFold))
    return _.toBoolean(hasFold)
end -- }}}

function M.foldIsCommented() -- {{{
    local s = vim.api.nvim_get_vvar('foldstart')
    local e = vim.api.nvim_get_vvar('foldend')
    local lines = u.getRange(s, e, {noEmpty = true})

    local areLinesCommented = _.map(lines, u.lineIsCommented)
    local answer = _.all(areLinesCommented, _.identity)

    -- debug {{{
    -- print(s, e, ':', answer, ' = ', vim.inspect(areLinesCommented))
    -- print(s, e, ':: answer ::', answer, ' = ', vim.inspect(lines))
    -- }}}
    return answer
end -- }}}

function M.linesWithFolds() -- {{{
    local lines = u.getRange()
    local lines_with_folds = {}
    for num, content in pairs(lines) do
        if M.lineStartsFold(content) then
            table.insert(lines_with_folds, num + 1)
        end
    end
    vim.api.nvim_buf_set_var(0, 'lines_with_folds', lines_with_folds)
    return lines_with_folds
end -- }}}

function M.countChildFolds() -- {{{
    local foldedLines = u.getBufVar('lines_with_folds') or M.linesWithFolds()
    local startline = vim.api.nvim_get_vvar('foldstart')
    local endline = vim.api.nvim_get_vvar('foldend')
    local lines = _.range(startline, endline)

    local numChildFolds = #_.intersection(lines, foldedLines)
    return numChildFolds - 1
end -- }}}

return M
