return {
  "windwp/nvim-autopairs",
  event = "User File",
  opts = {
    check_ts = true,
    enabled = function(bufnr) return require("utils.buffer").is_valid(bufnr) end,
    ts_config = { java = false },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0,
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  },
  config = function(_, opts)
    local npairs = require "nvim-autopairs"
    npairs.setup(opts)

    if not vim.g.autopairs_enabled then npairs.disable() end
  end
}
