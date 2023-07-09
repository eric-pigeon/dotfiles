return function(_, opts)
  local mason_lspconfig = require "mason-lspconfig"
  mason_lspconfig.setup(opts)
  mason_lspconfig.setup_handlers {
    function(server) require("utils.lsp").setup(server) end,
  }
  -- require("utils").event "MasonLspSetup"
end
