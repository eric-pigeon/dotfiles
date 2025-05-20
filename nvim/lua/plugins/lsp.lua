return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/neoconf.nvim", lazy = true, opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      version = "^1",
      dependencies = { "williamboman/mason.nvim" },
      cmd = { "LspInstall", "LspUninstall" },
      opts = function(_, opts)
        if not opts.handlers then opts.handlers = {} end
        opts.handlers[1] = function(server) require("utils.lsp").setup(server) end
      end,
      config = function(_, opts)
        local mason_lspconfig = require "mason-lspconfig"
        mason_lspconfig.setup(opts)
        mason_lspconfig.setup_handlers {
          function(server) require("utils.lsp").setup(server) end,
        }
        require("utils").event "MasonLspSetup"
      end
    },
  },
  event = "User File",
  config = function()
    local lsp = require "utils.lsp"
    local get_icon = require("utils").get_icon
    local signs = {
      { name = "DiagnosticSignError", text = get_icon "DiagnosticError", texthl = "DiagnosticSignError" },
      { name = "DiagnosticSignWarn", text = get_icon "DiagnosticWarn", texthl = "DiagnosticSignWarn" },
      { name = "DiagnosticSignHint", text = get_icon "DiagnosticHint", texthl = "DiagnosticSignHint" },
      { name = "DiagnosticSignInfo", text = get_icon "DiagnosticInfo", texthl = "DiagnosticSignInfo" },
      { name = "DapStopped", text = get_icon "DapStopped", texthl = "DiagnosticWarn" },
      { name = "DapBreakpoint", text = get_icon "DapBreakpoint", texthl = "DiagnosticInfo" },
      { name = "DapBreakpointRejected", text = get_icon "DapBreakpointRejected", texthl = "DiagnosticError" },
      { name = "DapBreakpointCondition", text = get_icon "DapBreakpointCondition", texthl = "DiagnosticInfo" },
      { name = "DapLogPoint", text = get_icon "DapLogPoint", texthl = "DiagnosticInfo" },
    }

    lsp.setup_diagnostics(signs)

    local setup_servers = function()
      vim.api.nvim_exec_autocmds("FileType", {})
      require("utils").event "LspSetup"
    end
    vim.api.nvim_create_autocmd("User", { pattern = "MasonLspSetup", once = true, callback = setup_servers })
  end
}
