-- vim: foldmethod=marker

-- Plugins Install {{{
require('packer').startup(function(use)
  -- Global {{{
  use { 'wbthomason/packer.nvim', opt = true }
  use { 'bkad/CamelCaseMotion' }
  use { 'itchyny/lightline.vim' }

  -- Simple easy to use alignment plugin
  use { 'junegunn/vim-easy-align' }
  -- Visual undo
  use { 'sjl/gundo.vim' }
  use { 'mhinz/vim-hugefile' }
  use { 'Yggdroot/indentLine' }
  use { 'mileszs/ack.vim' }
  use { 'janko/vim-test' }
  use { 'jgdavey/tslime.vim' }
  -- all the language packs
  use { 'sheerun/vim-polyglot' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } } -- Additional textobjects for treesitter
  use { 'scr1pt0r/crease.vim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
  -- }}}

  -- Git {{{
  use { 'tpope/vim-fugitive' }
  -- }}}

  -- -- NerdTree {{{
  -- use { 'scrooloose/nerdtree', cmd = 'NERDTreeToggle' }
  -- use { 'tyok/nerdtree-ack', required = {{'scrooloose/nerdtree'}}, after = 'nerdtree' }
  -- -- }}}
  use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
}

  -- snippet {{{
  -- Don't really want a snippet engine, but nvim-cmp currently requires one
  use { 'hrsh7th/vim-vsnip' }
  -- }}}

  -- Code Completion {{{
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use {'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/nvim-cmp' }
  -- }}}

  -- Color Schemes {{{
  -- Plug 'eric-pigeon/vim-256-color-schemes' " A variety of terminal based colorschemes
  -- Plug 'altercation/vim-colors-solarized'
  -- Plug 'arcticicestudio/nord-vim'
  use { 'drewtempelmeyer/palenight.vim' }
  -- Plug 'dracula/vim', { 'as': 'dracula' }
  -- }}}
end)
-- }}}

--- Ack.vim {{{
if vim.fn.executable('ag') == 1 then
  vim.g.ackprg = 'ag --vimgrep'
end
-- }}}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- test.vim {{{
vim.g['test#strategy'] = 'tslime'
vim.g['test#preserve_screen'] = 1
vim.g['test#echo_command'] = 0
vim.api.nvim_set_keymap('n', t'<Leader>'..'rt', ':TestFile'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'rs', ':TestNearest'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'rl', ':TestLast'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'ra', ':TestSuite'..t'<CR>', { noremap = true })
-- }}}

-- NerdTree {{{
-- vim.g.NERDTreeWinSize = 40
-- vim.g.NERDTreeShowHidden=1
-- vim.g.NERDTreeQuitOnOpen=0
-- vim.g.NERDTreeShowLineNumbers=1
-- vim.g.NERDTreeChDirMode=0
-- vim.g.NERDTreeShowBookmarks=1
-- vim.g.NERDTreeIgnore= {'.git','.hg','.pyc$'}
-- vim.api.nvim_set_keymap('n', t'<Leader>'..'nt', ':NERDTreeToggle'..t'<CR>', { noremap = true })
-- }}}

-- nvim tree {{{
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', t'<Leader>'..'nt', ':NvimTreeToggle'..t'<CR>', { noremap = true })
-- }}}

-- tslime.vim {{{
vim.g.tslime_always_current_session = 1
-- }}}

-- TreeSitter {{{
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      -- TODO: I'm not sure for this one.
      -- scope_incremental = '<c-s>',
      -- node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
-- }}}

-- LSP Settings {{{
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local servers = {
  'clangd', -- c/c++/objective-c
  'gopls', -- go
  'pyright', -- python
  'rust_analyzer', -- rust
  'solargraph', -- ruby
  'tsserver', -- typescript
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

local sumneko_root_path = vim.fn.getenv("HOME").."/.local/bin/lua-language-server"
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_root_path.."/bin/macOS/lua-language-server", "-E", sumneko_root_path.."/main.lua" };
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
-- }}}

-- telescope.vim {{{
require('telescope').setup {
  defaults = {
    prompt_title = "",
    results_title = false,
    preview_title = false,
    sorting_strategy = "ascending",
    layout_config = {
      preview_cutoff = 1, -- Preview should always show (unless previewer = false)
      horizontal = {
        prompt_position = "top",
      },
      width = 0.9,
      height = 0.7,
    },
    border = true,
    borderchars = {
      "z",
      prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
      results = {" ", "│", "─", "│", "│", "│", "╯", "╰"},
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    },
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

vim.cmd([[au VimEnter * highlight TelescopeBorder guifg=#888888]])
vim.api.nvim_set_keymap('n', '[telescope]', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<space>', '[telescope]', {})
vim.api.nvim_set_keymap('n', '[telescope]f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { silent = true })
vim.api.nvim_set_keymap('n', '[telescope]l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { silent = true })
vim.api.nvim_set_keymap('n', '[telescope]b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { silent = true })
vim.api.nvim_set_keymap('n', '[telescope]s', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '[telescope]d', [[<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>]], { noremap = true, silent = true})
-- }}}

-- lightline {{{
vim.g.lightline = {
  colorscheme = 'palenight';
  active = {
    left = {
      { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' }
    }
  };
  component_function = { gitbranch = 'FugitiveHead', };
}
-- }}}

-- easy align {{{
vim.api.nvim_set_keymap('v', t'<Enter>', '<Plug>(EasyAlign)', { })
-- }}}

-- cmp {{{
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'buffer' }
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      capabilities = capabilities
    }
  end
-- }}}

-- prettier {{{
vim.g['prettier#autoformat'] = 0
-- vim.g['prettier#autoformat_require_pragma'] = 0
-- }}}
