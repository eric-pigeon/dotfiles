return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  dependencies = {
    {
      "jay-babu/mason-null-ls.nvim",
      dependencies = { "williamboman/mason.nvim" },
      cmd = { "NullLsInstall", "NullLsUninstall" },
      opts = { ensure_installed = {}, handlers = {} },
      config = function(_, opts)
        local mason_null_ls = require "mason-null-ls"
        mason_null_ls.setup(opts)
      end
    },
  },
  event = "User File",
  opts = function() return { on_attach = require("utils.lsp").on_attach } end,
}
