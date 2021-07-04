-- vim: foldmethod=marker

-- Plugins Install {{{
require('packer').startup(function(use)
  -- Global {{{
  use { 'wbthomason/packer.nvim', opt = true }
  use { 'bkad/CamelCaseMotion' }
  use { '/usr/local/opt/fzf' }
  use { 'eric-pigeon/fzf.vim' }
  use { 'bling/vim-airline' }
 
  use { 'dense-analysis/ale' }
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
  use { 'scr1pt0r/crease.vim' }
  use { 'neovim/nvim-lspconfig' }
  -- use 'hrsh7th/nvim-compe'
  -- use 'ludovicchabant/vim-gutentags'
  -- use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  -- use 'itchyny/lightline.vim'
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
  use { 'neoclide/coc.nvim', branch = 'release' }
  -- }}}

  -- Color Schemes {{{
  -- Plug 'eric-pigeon/vim-256-color-schemes' " A variety of terminal based colorschemes
  -- Plug 'altercation/vim-colors-solarized'
  -- Plug 'arcticicestudio/nord-vim'
  use 'drewtempelmeyer/palenight.vim'
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

-- Ale {{{
vim.g.ale_fixers = { java = { 'google_java_format' } }
vim.g.ale_java_javac_sourcepath = { 'target/generated-sources' }
-- }}}

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

  local opts = { noremap=true, silent=true }
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local servers = { 'pyright', 'tsserver', 'rust_analyzer' }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
-- }}}
