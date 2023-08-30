return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require "telescope.actions"
    local get_icon = require("utils").get_icon
    return {
      defaults = {
        prompt_title = "",
        path_display = { "truncate" },
        results_title = false,
        preview_title = false,
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.8,
          preview_cutoff = 120,
        },
        border = true,
        borderchars = {
          "z",
          prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
          results = {" ", "│", "─", "│", "│", "│", "╯", "╰"},
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        },
        generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
        file_sorter =  require'telescope.sorters'.get_fzy_sorter,
      },
    }
  end,
  config = require "plugins.configs.telescope",
}
