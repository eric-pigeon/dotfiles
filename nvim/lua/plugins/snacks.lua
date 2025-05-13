return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = function(_, opts)
    local get_icon = require("utils").get_icon
    local buf_utils = require "utils.buffer"

    -- configure image support
    opts.image = {}

    -- configure `vim.ui.input`
    opts.input = {}

    -- configure notifier
    opts.notifier = {}
    opts.notifier.icons = {
      DEBUG = get_icon "Debugger",
      ERROR = get_icon "DiagnosticError",
      INFO = get_icon "DiagnosticInfo",
      TRACE = get_icon "DiagnosticHint",
      WARN = get_icon "DiagnosticWarn",
    }

    -- configure picker and `vim.ui.select`
    opts.picker = { ui_select = true }

    opts.indent = {
      indent = { char = "▏" },
      scope = { char = "▏" },
      filter = function(bufnr)
        return buf_utils.is_valid(bufnr)
           and not buf_utils.is_large(bufnr)
          and vim.g.snacks_indent ~= false
          and vim.b[bufnr].snacks_indent ~= false
      end,
      animate = { enabled = false },
    }

    opts.scope = {
      filter = function(bufnr) return buf_utils.is_valid(bufnr) and not buf_utils.is_large(bufnr) end,
    }

    opts.zen = {
      toggles = { dim = false, diagnostics = false, inlay_hints = false },
      on_open = function(win)
        -- disable snacks indent
        vim.b[win.buf].snacks_indent_old = vim.b[win.buf].snacks_indent
        vim.b[win.buf].snacks_indent = false
      end,
      on_close = function(win)
        -- restore snacks indent setting
        vim.b[win.buf].snacks_indent = vim.b[win.buf].snacks_indent_old
      end,
      win = {
        width = function() return math.min(120, math.floor(vim.o.columns * 0.75)) end,
        height = 0.9,
        backdrop = {
          transparent = false,
          win = { wo = { winhighlight = "Normal:Normal" } },
        },
        wo = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          foldcolumn = "0",
          winbar = "",
          list = false,
          showbreak = "NONE",
        },
      },
    }
  end
}
