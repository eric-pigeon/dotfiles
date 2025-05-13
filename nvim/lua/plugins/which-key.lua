return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = {
      group = vim.g.icons_enabled and "" or "+",
      separator = ""
    },
    disable = { filetypes = { "TelescopePrompt" } },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    require("utils").which_key_register()
  end,
}
