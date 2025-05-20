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
      end
    },
  },
  event = "User File",
}
