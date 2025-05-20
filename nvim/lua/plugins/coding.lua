return {
  { "b0o/SchemaStore.nvim", lazy = true },
  {
    "windwp/nvim-ts-autotag",
    event = "User File",
  },
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
    opts = {
      min_count_to_highlight = 2,
      should_enable = function(bufnr)
        local buf_utils = require "utils.buffer"
        return buf_utils.is_valid(bufnr) and not buf_utils.is_large(bufnr)
      end,
    }
  },
}
