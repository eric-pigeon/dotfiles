return function(_, opts)
  local telescope = require "telescope"
  telescope.setup(opts)
  telescope.load_extension("notify")
  telescope.load_extension("aerial")
  telescope.load_extension('fzf')
end
