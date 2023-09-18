local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local utils = require "utils"

-- Line Return {{{
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid or when inside an event handler
-- (happens when dropping a file on gvim).
-- Also don't do it when the mark is in the first line, that is the default
-- position when opening a file.
local line_return vim.api.nvim_create_augroup("line_return", { clear = true })
autocmd("BufReadPost", {
  group = line_return,
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.api.nvim_command("normal! g`\"")
    end
  end
})

--autocmd("BufReadPre", {
--  desc = "Disable certain functionality on very large files",
--  group = augroup("large_buf", { clear = true }),
--  callback = function(args)
--    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
--    vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
--      or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
--  end,
--})

local bufferline_group = augroup("bufferline", { clear = true })
autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
  desc = "Update buffers when adding new buffers",
  group = bufferline_group,
  callback = function(args)
    if not vim.t.bufs then vim.t.bufs = {} end
    local bufs = vim.t.bufs
    if not vim.tbl_contains(bufs, args.buf) then
      table.insert(bufs, args.buf)
      vim.t.bufs = bufs
    end
    vim.t.bufs = vim.tbl_filter(require("utils.buffer").is_valid, vim.t.bufs)
  end,
})
autocmd("BufDelete", {
  desc = "Update buffers when deleting buffers",
  group = bufferline_group,
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
    vim.t.bufs = vim.tbl_filter(require("utils.buffer").is_valid, vim.t.bufs)
    vim.cmd.redrawtabline()
  end,
})

autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc = "URL Highlighting",
  group = augroup("highlighturl", { clear = true }),
  callback = function() utils.set_url_match() end,
})

autocmd({ "BufReadPost", "BufNewFile" }, {
  group = augroup("file_user_events", { clear = true }),
  callback = function(args)
    if not (vim.fn.expand "%" == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile") then
      utils.event "File"
      if utils.cmd('git -C "' .. vim.fn.expand "%:p:h" .. '" rev-parse', false) then utils.event "GitFile" end
    end
  end,
})

-- Hightlight matched under cursor
autocmd("CursorMoved", {
  callback = function()
    if vim.fn.getfsize("@%") < 1000000 then
      vim.api.nvim_command(vim.fn.printf('match SpellLocal /\\<%s\\>/', vim.fn.escape(vim.fn.expand('<cword>'), '^$.*?/\\[]~')))
    end
  end,
})

vim.api.nvim_create_user_command("CloseHiddenBuffers", function()
  local open_buffers = {}

  for _, tab in pairs(vim.api.nvim_list_tabpages()) do
    for _, buf in pairs(vim.fn.tabpagebuflist(tab)) do
      open_buffers[buf] = true
    end
  end

  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    if vim.fn.buflisted(buf) and vim.api.nvim_buf_is_loaded(buf) and open_buffers[buf] == nil then
      vim.api.nvim_command("bdelete " .. buf)
    end
  end
end, {})
