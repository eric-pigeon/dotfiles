return {
  "RRethy/vim-illuminate",
  {
    "chrisgrieser/nvim-spider",
    event = "User File",
    keys = {
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "User File",
  }
}
