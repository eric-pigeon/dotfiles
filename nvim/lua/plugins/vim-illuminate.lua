return {
  "RRethy/vim-illuminate",
  event = "User File",
  opts = {
    delay = 200,
    min_count_to_highlight = 2,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end
}
