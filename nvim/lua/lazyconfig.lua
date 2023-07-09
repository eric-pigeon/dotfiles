--- vim: foldmethod=marker

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1
  vim.notify "Please wait while plugins are installed..."
  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module) pcall(require, module) end, { "nvim-treesitter", "mason" })
      require("utils").notify "Mason is installing packages if configured, check status with :Mason"
    end,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {{ import = "plugins" }},
  -- defaults = { lazy = true },
  -- install = { colorscheme = colorscheme },
  performance = {
    rtp = {
      -- paths = astronvim.supported_configs,
       disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
    },
  },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
})

-- -- Plugins Install {{{
-- require('packer').startup(function(use)
--   -- Global {{{
--   use { 'bkad/CamelCaseMotion' }
-- 
--   -- Simple easy to use alignment plugin
--   use { 'junegunn/vim-easy-align' }
--   -- all the language packs
--   use { 'sheerun/vim-polyglot' }
--   use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
--   use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
--   use { 'nvim-telescope/telescope-file-browser.nvim' }
--   use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
--   -- }}}
-- end)
-- -- }}}
-- 
-- -- test.vim {{{
-- vim.g['test#strategy'] = 'tslime'
-- vim.g['test#preserve_screen'] = 1
-- vim.g['test#echo_command'] = 0
-- vim.api.nvim_set_keymap('n', t'<Leader>'..'rt', ':TestFile'..t'<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', t'<Leader>'..'rs', ':TestNearest'..t'<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', t'<Leader>'..'rl', ':TestLast'..t'<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', t'<Leader>'..'ra', ':TestSuite'..t'<CR>', { noremap = true })
-- -- }}}
-- 
-- -- tslime.vim {{{
-- vim.g.tslime_always_current_session = 1
-- -- }}}
-- 
-- -- TreeSitter {{{
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "all",
--   ignore_install = { }, -- List of parsers to ignore installing
--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = '<c-space>',
--       node_incremental = '<c-space>',
--       -- TODO: I'm not sure for this one.
--       -- scope_incremental = '<c-s>',
--       -- node_decremental = '<c-backspace>',
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ['af'] = '@function.outer',
--         ['if'] = '@function.inner',
--         ['ac'] = '@class.outer',
--         ['ic'] = '@class.inner',
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         [']m'] = '@function.outer',
--         [']]'] = '@class.outer',
--       },
--       goto_next_end = {
--         [']M'] = '@function.outer',
--         [']['] = '@class.outer',
--       },
--       goto_previous_start = {
--         ['[m'] = '@function.outer',
--         ['[['] = '@class.outer',
--       },
--       goto_previous_end = {
--         ['[M'] = '@function.outer',
--         ['[]'] = '@class.outer',
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ['<leader>a'] = '@parameter.inner',
--       },
--       swap_previous = {
--         ['<leader>A'] = '@parameter.inner',
--       },
--     },
--   },
-- }
-- -- }}}
-- 
-- -- LSP Settings {{{
-- local nvim_lsp = require('lspconfig')
-- local on_attach = function(_client, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
-- 
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
-- 
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- 
--   local opts = { noremap = true, silent = true }
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- 
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- --   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- end
-- 
-- local servers = {
--   'clangd', -- c/c++/objective-c
--   'gopls', -- go
--   'pyright', -- python
--   'rust_analyzer', -- rust
--   'solargraph', -- ruby
--   'tsserver', -- typescript
-- }
-- 
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup { on_attach = on_attach }
-- end
-- 
-- require'lspconfig'.lua_ls.setup {
--   on_attach = on_attach,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
-- -- telescope.vim {{{
-- require('telescope').setup {
--   defaults = {
--     prompt_title = "",
--     results_title = false,
--     preview_title = false,
--     sorting_strategy = "ascending",
--     layout_config = {
--       preview_cutoff = 1, -- Preview should always show (unless previewer = false)
--       horizontal = {
--         prompt_position = "top",
--       },
--       width = 0.9,
--       height = 0.7,
--     },
--     border = true,
--     borderchars = {
--       "z",
--       prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
--       results = {" ", "│", "─", "│", "│", "│", "╯", "╰"},
--       preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
--     },
--     generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
--     file_sorter =  require'telescope.sorters'.get_fzy_sorter,
--   },
--   extensions = {
--     fzf = {
--       fuzzy = true,                    -- false will only do exact matching
--       override_generic_sorter = false, -- override the generic sorter
--       override_file_sorter = true,     -- override the file sorter
--       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                        -- the default case_mode is "smart_case"
--     }
--   }
-- }
-- 
-- vim.cmd([[au VimEnter * highlight TelescopeBorder guifg=#888888]])
-- vim.api.nvim_set_keymap('n', '[telescope]', '<nop>', { noremap = true })
-- vim.api.nvim_set_keymap('n', t'<space>', '[telescope]', {})
-- vim.api.nvim_set_keymap('n', '[telescope]f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { silent = true })
-- vim.api.nvim_set_keymap('n', '[telescope]l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { silent = true })
-- vim.api.nvim_set_keymap('n', '[telescope]b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { silent = true })
-- vim.api.nvim_set_keymap('n', '[telescope]s', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '[telescope]d', [[<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>]], { noremap = true, silent = true})
-- -- }}}

-- -- easy align {{{
-- vim.api.nvim_set_keymap('v', t'<Enter>', '<Plug>(EasyAlign)', { })
-- -- }}}
