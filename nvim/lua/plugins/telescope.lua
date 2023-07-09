--  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
--  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
--  use { 'nvim-telescope/telescope-file-browser.nvim' }
--
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
  },
  opts = function()
    return {
      defaults = {
        prompt_title = "",
        path_display = { "truncate" },
        results_title = false,
        preview_title = false,
        sorting_strategy = "ascending",
        layout_config = {
          preview_cutoff = 1, -- Preview should always show (unless previewer = false)
          horizontal = {
            prompt_position = "top",
          },
          width = 0.9,
          height = 0.7,
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
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
      }
    }

    -- local actions = require "telescope.actions"
    -- local get_icon = require("astronvim.utils").get_icon
    -- return {
    --   defaults = {
    --     prompt_prefix = string.format("%s ", get_icon "Search"),
    --     selection_caret = string.format("%s ", get_icon "Selected"),
    --     path_display = { "truncate" },
    --     sorting_strategy = "ascending",
    --     layout_config = {
    --       horizontal = {
    --         prompt_position = "top",
    --         preview_width = 0.55,
    --       },
    --       vertical = {
    --         mirror = false,
    --       },
    --       width = 0.87,
    --       height = 0.80,
    --       preview_cutoff = 120,
    --     },

    --     mappings = {
    --       i = {
    --         ["<C-n>"] = actions.cycle_history_next,
    --         ["<C-p>"] = actions.cycle_history_prev,
    --         ["<C-j>"] = actions.move_selection_next,
    --         ["<C-k>"] = actions.move_selection_previous,
    --       },
    --       n = { ["q"] = actions.close },
    --     },
    --   },
    -- }
  end,
  config = require "plugins.configs.telescope",
}
