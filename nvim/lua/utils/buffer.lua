--- ### AstroNvim Buffer Utilities
--
-- Buffer management related utility functions
--
-- This module can be loaded with `local buffer_utils = require "astronvim.utils.buffer"`
--
-- @module astronvim.utils.buffer
-- @copyright 2022
-- @license GNU General Public License v3.0

local M = {}

--- Placeholders for keeping track of most recent and previous buffer
M.current_buf, M.last_buf = nil, nil

--- Check if a buffer is valid
---@param bufnr? integer The buffer to check, default to current buffer
---@return boolean # Whether the buffer is valid or not
function M.is_valid(bufnr)
  if not bufnr then bufnr = 0 end
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

local large_buf_cache, buf_size_cache = {}, {} -- cache large buffer detection results and buffer sizes
--- Check if a buffer is a large buffer (always returns false if large buffer detection is disabled)
---@param bufnr? integer the buffer to check the size of, default to current buffer
---@param large_buf_opts? AstroCoreMaxFile large buffer parameters, default to AstroCore configuration
---@return boolean is_large whether the buffer is detected as large or not
function M.is_large(bufnr, large_buf_opts)
  if not bufnr then bufnr = vim.api.nvim_get_current_buf() end
  local skip_cache = large_buf_opts ~= nil -- skip cache when called manually with custom options
  large_buf_opts = {
    enabled = function(bufnrr) return M.is_valid(bufnrr) end,
    notify = true,
    size = 1.5 * 1024 * 1024,
    lines = 100000,
    line_length = 1000,
  }

  if skip_cache or large_buf_cache[bufnr] == nil then
    local enabled = vim.tbl_get(large_buf_opts, "enabled")
    if type(enabled) == "function" then
      large_buf_opts = vim.deepcopy(large_buf_opts)
      enabled = enabled(bufnr, large_buf_opts)
      if type(enabled) == "table" then large_buf_opts = enabled end
    end
    local large_buf = false
    if vim.F.if_nil(enabled, true) then
      if not buf_size_cache[bufnr] then
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        buf_size_cache[bufnr] = ok and stats and stats.size or 0
      end
      local file_size = buf_size_cache[bufnr]
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      local too_large = large_buf_opts.size and file_size > large_buf_opts.size
      local too_long = large_buf_opts.lines and line_count > large_buf_opts.lines
      local too_wide = large_buf_opts.line_length and (file_size / line_count) - 1 > large_buf_opts.line_length
      large_buf = too_large or too_long or too_wide or false
    end
    if skip_cache then return large_buf end
    large_buf_cache[bufnr] = large_buf
  end
  return large_buf_cache[bufnr]
end
--- Move the current buffer tab n places in the bufferline
---@param n integer The number of tabs to move the current buffer over by (positive = right, negative = left)
function M.move(n)
  if n == 0 then return end -- if n = 0 then no shifts are needed
  local bufs = vim.t.bufs -- make temp variable
  for i, bufnr in ipairs(bufs) do -- loop to find current buffer
    if bufnr == vim.api.nvim_get_current_buf() then -- found index of current buffer
      for _ = 0, (n % #bufs) - 1 do -- calculate number of right shifts
        local new_i = i + 1 -- get next i
        if i == #bufs then -- if at end, cycle to beginning
          new_i = 1 -- next i is actually 1 if at the end
          local val = bufs[i] -- save value
          table.remove(bufs, i) -- remove from end
          table.insert(bufs, new_i, val) -- insert at beginning
        else -- if not at the end,then just do an in place swap
          bufs[i], bufs[new_i] = bufs[new_i], bufs[i]
        end
        i = new_i -- iterate i to next value
      end
      break
    end
  end
  vim.t.bufs = bufs -- set buffers
  require("utils").event "BufsUpdated"
  vim.cmd.redrawtabline() -- redraw tabline
end

--- Navigate left and right by n places in the bufferline
---@param n integer The number of tabs to navigate to (positive = right, negative = left)
function M.nav(n)
  local current = vim.api.nvim_get_current_buf()
  for i, v in ipairs(vim.t.bufs) do
    if current == v then
      vim.cmd.b(vim.t.bufs[(i + n - 1) % #vim.t.bufs + 1])
      break
    end
  end
end

--- Close a given buffer
---@param bufnr? integer The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close(bufnr, force)
  if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
  if M.is_valid(bufnr) and #vim.t.bufs > 1 then
    require("snacks").bufdelete { buf = bufnr, force = force }
  end
end

--- Close all buffers
---@param keep_current? boolean Whether or not to keep the current buffer (default: false)
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_all(keep_current, force)
  if keep_current == nil then keep_current = false end
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs) do
    if not keep_current or bufnr ~= current then M.close(bufnr, force) end
  end
end

--- Close buffers to the left of the current buffer
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_left(force)
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs) do
    if bufnr == current then break end
    M.close(bufnr, force)
  end
end

--- Close buffers to the right of the current buffer
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close_right(force)
  local current = vim.api.nvim_get_current_buf()
  local after_current = false
  for _, bufnr in ipairs(vim.t.bufs) do
    if after_current then M.close(bufnr, force) end
    if bufnr == current then after_current = true end
  end
end

--- Close the current tab
function M.close_tab()
  if #vim.api.nvim_list_tabpages() > 1 then
    tabpage = tabpage or vim.api.nvim_get_current_tabpage()
    vim.t[tabpage].bufs = nil
    require("utils").event "BufsUpdated"
    vim.cmd.tabclose(vim.api.nvim_tabpage_get_number(tabpage))
  end
end

return M
