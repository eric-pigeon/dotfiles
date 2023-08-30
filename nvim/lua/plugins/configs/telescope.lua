return function(_, opts)
  local telescope = require "telescope"
  telescope.setup(opts)
  require('telescope').load_extension('fzf')
end
