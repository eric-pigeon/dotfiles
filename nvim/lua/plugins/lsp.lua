return {
  { "b0o/SchemaStore.nvim", lazy = true },
  { "folke/neodev.nvim", lazy = true, options = {} },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
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
  {
    "stevearc/aerial.nvim",
    event = "User File",
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      keymaps = {
        ["[y"] = "actions.prev",
        ["]y"] = "actions.next",
        ["[Y"] = "actions.prev_up",
        ["]Y"] = "actions.next_up",
        ["{"] = false,
        ["}"] = false,
        ["[["] = false,
        ["]]"] = false,
      },
    },
  },
}
