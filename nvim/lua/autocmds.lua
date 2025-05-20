local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local utils = require "utils"
local event = utils.event

autocmd("BufReadPre", {
  desc = "Disable certain functionality on very large files",
  group = augroup("large_buf", { clear = true }),
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
      or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
  end,
})

local bufferline_group = augroup("bufferline", { clear = true })
autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
  desc = "Update buffers when adding new buffers",
  group = bufferline_group,
  callback = function(args)
    local buf_utils = require "utils.buffer"
    if not vim.t.bufs then vim.t.bufs = {} end
    if not buf_utils.is_valid(args.buf) then return end
    if args.buf ~= buf_utils.current_buf then
      buf_utils.last_buf = buf_utils.is_valid(buf_utils.current_buf) and buf_utils.current_buf or nil
      buf_utils.current_buf = args.buf
    end
    local bufs = vim.t.bufs
    if not vim.tbl_contains(bufs, args.buf) then
      table.insert(bufs, args.buf)
      vim.t.bufs = bufs
    end
    vim.t.bufs = vim.tbl_filter(require("utils.buffer").is_valid, vim.t.bufs)
    event "BufsUpdated"
  end,
})
autocmd({ "BufDelete", "TermClose" }, {
  desc = "Update buffers when deleting buffers",
  group = bufferline_group,
  callback = function(args)
    local removed
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            removed = true
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
    vim.t.bufs = vim.tbl_filter(require("utils.buffer").is_valid, vim.t.bufs)
    if removed then event "BufsUpdated" end
    vim.cmd.redrawtabline()
  end,
})

autocmd({ "BufReadPost", "BufNewFile" }, {
  desc = "User events for file detection (File and GitFile)",
  group = augroup("file_user_events", { clear = true }),
  callback = function(args)
    local current_file = vim.fn.resolve(vim.fn.expand "%")
    if not (current_file == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile") then
      event "File"
      if
        require("utils.git").file_worktree()
        or utils.cmd({ "git", "-C", vim.fn.fnamemodify(current_file, ":p:h"), "rev-parse" }, false)
      then
        utils.event "GitFile"
        vim.api.nvim_del_augroup_by_name "file_user_events"
      end
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
