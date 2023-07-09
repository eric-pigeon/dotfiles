return {
  -- "b0o/SchemaStore.nvim",
  -- -- {
  -- --   "folke/neodev.nvim",
  -- --   opts = {
  -- --     override = function(root_dir, library)
  -- --       for _, astronvim_config in ipairs(astronvim.supported_configs) do
  -- --         if root_dir:match(astronvim_config) then
  -- --           library.plugins = true
  -- --           break
  -- --         end
  -- --       end
  -- --       vim.b.neodev_enabled = library.enabled
  -- --     end,
  -- --   },
  -- -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = require "plugins.configs.mason-lspconfig",
      },
    },
    event = "User File",
    config = require "plugins.configs.lspconfig",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
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
