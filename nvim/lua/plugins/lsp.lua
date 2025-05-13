return {
  { "b0o/SchemaStore.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", lazy = true, opts = {} },
      {
        "williamboman/mason-lspconfig.nvim",
        version = "^1",
        cmd = { "LspInstall", "LspUninstall" },
        dependencies = { "williamboman/mason.nvim" },
        opts = function(_, opts)
          if not opts.handlers then opts.handlers = {} end
          opts.handlers[1] = function(server) require("utils.lsp").setup(server) end
        end,
        config = require "plugins.configs.mason-lspconfig",
      },
    },
    event = "User File",
    config = require "plugins.configs.lspconfig",
  },
  {
    "nvimtools/none-ls.nvim",
    main = "null-ls",
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        cmd = { "NullLsInstall", "NullLsUninstall" },
        opts = { handlers = {} },
      },
    },
    event = "User File",
    opts = function() return { on_attach = require("utils.lsp").on_attach } end,
  },
}
