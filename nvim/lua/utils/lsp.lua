local M = {}

local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty

local utils = require "utils"
local is_available = utils.is_available
local extend_tbl = utils.extend_tbl

local server_config = "lsp.config"
local setup_handlers = {
  function(server, opts) require("lspconfig")[server].setup(opts) end,
}

M.diagnostics = { [0] = {}, {}, {}, {} }

M.formatting = { format_on_save = { enabled = true }, disabled = {} }
if type(M.formatting.format_on_save) == "boolean" then
  M.formatting.format_on_save = { enabled = M.formatting.format_on_save }
end

M.format_opts = vim.deepcopy(M.formatting)
M.format_opts.disabled = nil
M.format_opts.format_on_save = nil
M.format_opts.filter = function(client)
  local filter = M.formatting.filter
  local disabled = M.formatting.disabled or {}
  -- check if client is fully disabled or filtered by function
  return not (vim.tbl_contains(disabled, client.name) or (type(filter) == "function" and not filter(client)))
end

--- Helper function to set up a given server with the Neovim LSP client
---@param server string The name of the server to be setup
M.setup = function(server)
  -- if server doesn't exist, set it up from user server definition
  -- local config_avail, config = pcall(require, "lspconfig.server_configurations." .. server)
  -- if not config_avail or not config.default_config then
  --   local server_definition = user_opts(server_config .. server)
  --   if server_definition.cmd then require("lspconfig.configs")[server] = { default_config = server_definition } end
  -- end
  local opts = M.config(server)
  local setup_handler = setup_handlers[server] or setup_handlers[1]
  if setup_handler then setup_handler(server, opts) end
end

-- local function add_buffer_autocmd(augroup, bufnr, autocmds)
--   if not vim.tbl_islist(autocmds) then autocmds = { autocmds } end
--   local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
--   if not cmds_found or vim.tbl_isempty(cmds) then
--     vim.api.nvim_create_augroup(augroup, { clear = false })
--     for _, autocmd in ipairs(autocmds) do
--       local events = autocmd.events
--       autocmd.events = nil
--       autocmd.group = augroup
--       autocmd.buffer = bufnr
--       vim.api.nvim_create_autocmd(events, autocmd)
--     end
--   end
-- end

local function del_buffer_autocmd(augroup, bufnr)
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if cmds_found then vim.tbl_map(function(cmd) vim.api.nvim_del_autocmd(cmd.id) end, cmds) end
end

--- The `on_attach` function used by AstroNvim
---@param client vim.lsp.Client The LSP client details when attaching
---@param bufnr integer The buffer that the LSP client is attaching to
function M.on_attach(client, bufnr)
  local lsp_mappings = require("utils").empty_map_table()

  lsp_mappings.n["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
  lsp_mappings.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }

  if is_available "telescope.nvim" then
    lsp_mappings.n["<leader>lD"] =
      { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
  end

  if is_available "mason-lspconfig.nvim" then
    lsp_mappings.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
  end

  if is_available "null-ls.nvim" then
    lsp_mappings.n["<leader>lI"] = { "<cmd>NullLsInfo<cr>", desc = "Null-ls information" }
  end

  if client:supports_method "textDocument/codeAction" then
    lsp_mappings.n["<leader>la"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
    }
    lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
  end

  if client:supports_method("textDocument/codeLens", bufnr) then
    vim.lsp.codelens.refresh { bufnr = bufnr }
  end

  if client:supports_method "textDocument/declaration" then
    lsp_mappings.n["gD"] = {
      function() vim.lsp.buf.declaration() end,
      desc = "Declaration of current symbol",
    }
  end

  if client:supports_method "textDocument/definition" then
    lsp_mappings.n["gd"] = {
      function() vim.lsp.buf.definition() end,
      desc = "Show the definition of current symbol",
    }
  end

  if client:supports_method "textDocument/formatting" and not tbl_contains(M.formatting.disabled, client.name) then
    lsp_mappings.n["<leader>lf"] = {
      function() vim.lsp.buf.format(M.format_opts) end,
      desc = "Format buffer",
    }
    lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

    vim.api.nvim_buf_create_user_command(
      bufnr,
      "Format",
      function() vim.lsp.buf.format(M.format_opts) end,
      { desc = "Format file with LSP" }
    )
    -- local autoformat = M.formatting.format_on_save
    -- local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    -- if
    --   autoformat.enabled
    --   and (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype))
    --   and (tbl_isempty(autoformat.ignore_filetypes or {}) or not tbl_contains(autoformat.ignore_filetypes, filetype))
    -- then
    --   add_buffer_autocmd("lsp_auto_format", bufnr, {
    --     events = "BufWritePre",
    --     desc = "autoformat on save",
    --     callback = function()
    --       if not M.has_capability("textDocument/formatting", { bufnr = bufnr }) then
    --         del_buffer_autocmd("lsp_auto_format", bufnr)
    --         return
    --       end
    --       local autoformat_enabled = vim.b.autoformat_enabled
    --       if autoformat_enabled == nil then autoformat_enabled = vim.g.autoformat_enabled end
    --       if autoformat_enabled and ((not autoformat.filter) or autoformat.filter(bufnr)) then
    --         vim.lsp.buf.format(extend_tbl(M.format_opts, { bufnr = bufnr }))
    --       end
    --     end,
    --   })
    --   lsp_mappings.n["<leader>uf"] = {
    --     function() require("utils.ui").toggle_buffer_autoformat() end,
    --     desc = "Toggle autoformatting (buffer)",
    --   }
    --   lsp_mappings.n["<leader>uF"] = {
    --     function() require("utils.ui").toggle_autoformat() end,
    --     desc = "Toggle autoformatting (global)",
    --   }
    -- end
  end

  if client:supports_method "textDocument/implementation" then
    lsp_mappings.n["gI"] = {
      function() vim.lsp.buf.implementation() end,
      desc = "Implementation of current symbol",
    }
  end

  if client:supports_method "textDocument/inlayHint" then
    if vim.b.inlay_hints_enabled == nil then vim.b.inlay_hints_enabled = vim.g.inlay_hints_enabled end

    if vim.b.inlay_hints_enabled then vim.lsp.inlay_hint.enable(bufnr, true) end
    lsp_mappings.n["<leader>uH"] = {
      function() require("astronvim.utils.ui").toggle_buffer_inlay_hints(bufnr) end,
      desc = "Toggle LSP inlay hints (buffer)",
    }
  end

  if client:supports_method "textDocument/references" then
    lsp_mappings.n["gr"] = {
      function() vim.lsp.buf.references() end,
      desc = "References of current symbol",
    }
    lsp_mappings.n["<leader>lR"] = {
      function() vim.lsp.buf.references() end,
      desc = "Search references",
    }
  end

  if client:supports_method "textDocument/rename" then
    lsp_mappings.n["<leader>lr"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    }
  end

  if client:supports_method "textDocument/signatureHelp" then
    lsp_mappings.n["<leader>lh"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
    }
  end

  if client:supports_method "textDocument/typeDefinition" then
    lsp_mappings.n["gT"] = {
      function() vim.lsp.buf.type_definition() end,
      desc = "Definition of current type",
    }
  end

  if client:supports_method "workspace/symbol" then
    lsp_mappings.n["<leader>lG"] = { function() vim.lsp.buf.workspace_symbol() end, desc = "Search workspace symbols" }
  end

  if client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens then
    if vim.g.semantic_tokens_enabled then
      vim.b[bufnr].semantic_tokens_enabled = true
      lsp_mappings.n["<leader>uY"] = {
        function() require("astronvim.utils.ui").toggle_buffer_semantic_tokens(bufnr) end,
        desc = "Toggle LSP semantic highlight (buffer)",
      }
    else
      client.server_capabilities.semanticTokensProvider = nil
    end
  end

  if is_available "telescope.nvim" then -- setup telescope mappings if available
    if lsp_mappings.n.gd then lsp_mappings.n.gd[1] = function() require("telescope.builtin").lsp_definitions() end end
    if lsp_mappings.n.gI then
      lsp_mappings.n.gI[1] = function() require("telescope.builtin").lsp_implementations() end
    end
    if lsp_mappings.n.gr then lsp_mappings.n.gr[1] = function() require("telescope.builtin").lsp_references() end end
    if lsp_mappings.n["<leader>lR"] then
      lsp_mappings.n["<leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
    end
    if lsp_mappings.n.gT then
      lsp_mappings.n.gT[1] = function() require("telescope.builtin").lsp_type_definitions() end
    end
    if lsp_mappings.n["<leader>lG"] then
      lsp_mappings.n["<leader>lG"][1] = function()
        vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
          if query then
            -- word under cursor if given query is empty
            if query == "" then query = vim.fn.expand "<cword>" end
            require("telescope.builtin").lsp_workspace_symbols {
              query = query,
              prompt_title = ("Find word (%s)"):format(query),
            }
          end
        end)
      end
    end
  end

  if not vim.tbl_isempty(lsp_mappings.v) then
    lsp_mappings.v["<leader>l"] = { name = (vim.g.icons_enabled and " " or "") .. "LSP" }
  end
  utils.set_mappings(lsp_mappings, { buffer = bufnr })

end

--- The default AstroNvim LSP capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.capabilities.textDocument.completion.completionItem.resolveSupport =
  { properties = { "documentation", "detail", "additionalTextEdits" } }
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
-- M.capabilities = user_opts("lsp.capabilities", M.capabilities)
-- M.flags = user_opts "lsp.flags"

--- Get the server configuration for a given language server to be provided to the server's `setup()` call
---@param server_name string The name of the server
---@return table # The table of LSP options used when setting up the given language server
function M.config(server_name)
  local server = require("lspconfig")[server_name]
  local lsp_opts = extend_tbl(server, { capabilities = M.capabilities, flags = M.flags })
  if server_name == "jsonls" then -- by default add json schemas
    local schemastore_avail, schemastore = pcall(require, "schemastore")
    if schemastore_avail then
      lsp_opts.settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } }
    end
  end
  if server_name == "yamlls" then -- by default add yaml schemas
    local schemastore_avail, schemastore = pcall(require, "schemastore")
    if schemastore_avail then lsp_opts.settings = { yaml = { schemas = schemastore.yaml.schemas() } } end
  end
  local opts = lsp_opts
  local old_on_attach = server.on_attach
  local user_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    if type(old_on_attach) == "function" then old_on_attach(client, bufnr) end
    M.on_attach(client, bufnr)
    if type(user_on_attach) == "function" then user_on_attach(client, bufnr) end
  end
  return opts
end

return M
