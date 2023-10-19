local ignore_filetypes = {
  "aerial",
  "alpha",
  "dashboard",
  "help",
  "lazy",
  "mason",
  "neo-tree",
  "NvimTree",
  "neogitstatus",
  "notify",
  "startify",
  "toggleterm",
  "Trouble",
}
local ignore_buftypes = {
  "nofile",
  "prompt",
  "quickfix",
  "terminal",
}

return {
  "echasnovski/mini.indentscope",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
        indent = { char = char },
        scope = { enabled = false },
        exclude = {
          buftypes = ignore_buftypes,
          filetypes = ignore_filetypes,
        },
      },
    },
  },
  opts = function()
    return {
      draw = { delay = 0, animation = function() return 0 end },
      options = { try_as_border = true },
      symbol = "▏"
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Disable indentscope for certain filetypes",
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
    vim.api.nvim_create_autocmd("TermOpen", {
      desc = "Disable indentscope for terminals",
      callback = function(event)
        if vim.b[event.buf].minicursorword_disable == nil then vim.b[event.buf].miniindentscope_disable = true end
      end,
    })
  end,
}
