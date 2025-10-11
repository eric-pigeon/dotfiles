return {
  "mason-org/mason-lspconfig.nvim",
  event = "User File",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "neovim/nvim-lspconfig",
      opts = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        return {
          capabilities = capabilities
        }
      end,
      config = vim.schedule_wrap(function(_, opts)
        if opts.capabilities then
          vim.lsp.config("*", { capabilities = opts.capabilities })

          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local bufnr = args.buf ---@type number
              local client = vim.lsp.get_client_by_id(args.data.client_id)

              -- don't trigger on invalid buffers
              if not vim.api.nvim_buf_is_valid(bufnr) then
                return
              end
              -- don't trigger on non-listed buffers
              if not vim.bo[bufnr].buflisted then
                return
              end
              -- don't trigger on nofile buffers
              if vim.bo[bufnr].buftype == "nofile" then
                return
              end

              if client == nil then
                return
              end

              local utils = require("utils")
              local lsp_mappings = utils.empty_map_table()

              lsp_mappings.n["<leader>ld"] = {
                function() vim.diagnostic.open_float() end,
                desc = "Hover diagnostics"
              }
              lsp_mappings.n["gl"] = {
                function() vim.diagnostic.open_float() end,
                desc = "Hover diagnostics"
              }

              if client:supports_method("textDocument/codeLens", bufnr) then
                vim.lsp.codelens.refresh { bufnr = bufnr }
              end

              if client:supports_method("textDocument/formatting", bufnr) then
                lsp_mappings.n["<leader>lf"] = {
                  function() vim.lsp.buf.format() end,
                  desc = "Format buffer",
                }
                lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]
                -- TODO: format on save
              end

              if client:supports_method "textDocument/codeAction" then
                lsp_mappings.n["<leader>la"] = {
                  function() vim.lsp.buf.code_action() end,
                  desc = "LSP code action",
                }
                lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
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

              if client:supports_method "textDocument/implementation" then
                lsp_mappings.n["gI"] = {
                  function() vim.lsp.buf.implementation() end,
                  desc = "Implementation of current symbol",
                }
              end
              if client:supports_method "textDocument/inlayHint" then
                -- TODO: disable large buffers?
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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
                lsp_mappings.n["<leader>lG"] = {
                  function() vim.lsp.buf.workspace_symbol() end,
                  desc =
                  "Search workspace symbols"
                }
              end

              if utils.is_available "telescope.nvim" then
                lsp_mappings.n["<leader>lD"] = {
                  function() require("telescope.builtin").diagnostics() end,
                  desc = "Search diagnostics"
                }
              end

              if not vim.tbl_isempty(lsp_mappings.v) then
                lsp_mappings.v["<leader>l"] = { name = (vim.g.icons_enabled and " " or "") .. "LSP" }
              end

              utils.set_mappings(lsp_mappings, { buffer = bufnr })
            end
          })
        end
      end),
    },
  },
}
