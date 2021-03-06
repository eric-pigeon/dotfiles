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
  use { 'janko/vim-test' }
  use { 'jgdavey/tslime.vim' }
  -- all the language packs
  use { 'sheerun/vim-polyglot' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'scr1pt0r/crease.vim' }
  use { 'neovim/nvim-lspconfig' }
  -- use 'ludovicchabant/vim-gutentags'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
  -- use 'lewis6991/gitsigns.nvim'
  -- }}}

  -- Git {{{
  use { 'tpope/vim-fugitive' }
  -- }}}

  -- NerdTree {{{
  use { 'scrooloose/nerdtree', cmd = 'NERDTreeToggle' }
  use { 'tyok/nerdtree-ack', cmd = 'NERDTreeToggle' }
  -- }}}

  -- Code Completion {{{
  use { 'hrsh7th/nvim-compe' }
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

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- test.vim {{{
vim.g['test#strategy'] = 'tslime'
vim.g['test#preserve_screen'] = 1
vim.api.nvim_set_keymap('n', t'<Leader>'..'rt', ':TestFile'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'rs', ':TestNearest'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'rl', ':TestLast'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'ra', ':TestSuite'..t'<CR>', { noremap = true })
-- }}}

-- NerdTree {{{
vim.g.NERDTreeWinSize = 40
vim.g.NERDTreeShowHidden=1
vim.g.NERDTreeQuitOnOpen=0
vim.g.NERDTreeShowLineNumbers=1
vim.g.NERDTreeChDirMode=0
vim.g.NERDTreeShowBookmarks=1
vim.g.NERDTreeIgnore= {'.git','.hg','.pyc$'}
vim.api.nvim_set_keymap('n', t'<Leader>'..'nt', ':NERDTreeToggle'..t'<CR>', { noremap = true })
-- }}}

-- tslime.vim {{{
vim.g.tslime_always_current_session = 1
--}}}

-- TreeSitter {{{
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  indent = {
    enable = true,
  }
}
-- }}}

-- LSP Settings {{{
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
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
      -- { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
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

vim.cmd([[au VimEnter * highlight TelescopeBorder guifg=#888888]])
vim.api.nvim_set_keymap('n', '[telescope]', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<space>', '[telescope]', {})
vim.api.nvim_set_keymap('n', '[telescope]f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { silent = true })
vim.api.nvim_set_keymap('n', '[telescope]l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { silent = true })
vim.api.nvim_set_keymap('n', '[telescope]b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { silent = true })
vim.api.nvim_set_keymap('n', '[telescope]s', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
-- }}}

-- lightline {{{
vim.g.lightline = {
  colorscheme = 'palenight';
  active = {
    left = {
      { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' }
    }
  };
  component_function = { gitbranch = 'fugitive#head', };
}
-- }}}

-- easy align {{{
vim.api.nvim_set_keymap('v', t'<Enter>', '<Plug>(EasyAlign)', { })
-- }}}

-- compe {{{
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = false;
    snippets_nvim = true;
    treesitter = true;
  };
}

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- }}}
