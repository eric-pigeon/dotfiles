-- vim: foldmethod=marker

-- Install packer {{{
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
--- }}}

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function source_rc(path)
  vim.cmd('source '..vim.fn.fnameescape(vim.fn.expand('~/.config/nvim/rc/'..path)))
end

require('plugins')

-- TODO
source_rc('plugins.rc.vim')
source_rc('functions.rc.vim')

-- TODO
vim.fn['camelcasemotion#CreateMotionMappings']('<leader>')

-- Basic Settings {{{
-- map leader
vim.g.mapleader = "\\"
vim.cmd([[syntax on]])
-- spelling
vim.o.dictionary = "/usr/share/dict/words"
vim.o.thesaurus = "$HOME/.thesaurus"
-- osx clipboard
vim.o.clipboard = "unnamed,unnamedplus"
-- dont wrap text
vim.o.textwidth = 0
-- automatic indenting
vim.o.autoindent = true
-- keep 50 lines of command line history
vim.o.history = 50
-- displays incomplete commands
vim.g.showcmd = true
-- allow backspace over everything in insert mode
vim.o.backspace = "indent,eol,start"
-- show the cursor position all the time
vim.o.ruler = true
-- handle multiple buffers better
vim.o.hidden = true
--Incremental live completion
vim.o.inccommand = "nosplit"
-- change terminals title
vim.o.title = true
-- no beeping.
vim.o.visualbell = true
--Enable mouse mode
vim.o.mouse = "a"
--Enable break indent
vim.o.breakindent = true
-- show the status line all the time
vim.o.laststatus = 2
-- goth mode
vim.o.background = "dark"
--Add map to enter paste mode
vim.o.pastetoggle=  "<F2>"
-- special character display
vim.o.list = true
vim.o.listchars = "tab:┊ ,eol:¬,extends:❯,precedes:❮,trail:-,nbsp:+"

-- Make line numbers default
vim.wo.number = true
-- Use relative line number
vim.wo.relativenumber = true
-- don't wrap text
vim.wo.wrap = false
-- highlight current line
vim.wo.cursorline = true
--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Show current line highlight when entering a window
vim.cmd([[au WinEnter * setlocal cursorline]])
-- Remove current line highlight when leaving a window
vim.cmd([[au WinLeave * setlocal nocursorline]])
-- Automatically save files when they lose focus
vim.cmd([[au FocusLost * :wa]])
-- Resize splits when the window is resized
vim.cmd([[au VimResized * :wincmd =]])
-- }}}

-- Backups/Swap Files/Undo File {{{
-- don't make a backup before overwritting a file.
vim.cmd[[set nobackup]]
-- and again.
vim.cmd[[set nowritebackup]]
-- Save undo history
vim.cmd[[set undofile]]
vim.cmd[[set undoreload=10000]]
-- keep swap files in one location
vim.cmd[[set directory=$XDG_STATE_HOME/nvim/swap/]]
-- undo files location
vim.cmd[[set undodir=$XDG_STATE_HOME/nvim/undo/]]
--  backups location
vim.cmd[[set backupdir=$XDG_STATE_HOME/nvim/backup/]]
-- }}}

-- Searching and Movement {{{
-- case-insensitive searching
vim.o.ignorecase = true
-- Search case-insensitive when search string is all-lowercase, otherwise search case-sensitive
vim.o.smartcase = true
-- do incremental searching
vim.o.incsearch = true
-- --Set highlight on search
vim.o.hlsearch = true
vim.o.showmatch = true
-- Lines of context around the cursor.
vim.o.scrolloff = 4
vim.o.sidescroll = 1
vim.o.sidescrolloff = 10
vim.o.virtualedit = "block"
-- Highlight current word matches
vim.cmd([[autocmd CursorMoved * if getfsize(@%) < 1000000 | silent! exe printf('match SpellLocal /\<%s\>/', expand('<cword>')) | endif]])
vim.cmd([[hi CursorLine cterm=NONE ctermfg=NONE ctermbg=235 guibg=#222222]])
-- }}}

-- WildMenu Completion {{{
-- enhanced command line completion.
vim.o.wildmenu = true
-- complete files like a shell.
vim.o.wildmode = "list:longest,list:full"
-- TODO
-- set wildignore+=.hg,.git,.svn                     " Version control
-- set wildignore+=*.aux,*.out,*.toc                 " LaTeX intermediate files
-- set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " binary images
-- set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  " compiled object files
-- set wildignore+=*.spl                             " compiled spelling word lists
-- set wildignore+=*.sw?                             " Vim swap files
-- set wildignore+=*.DS_Store                        " OSX bullshit
vim.o.wildignore = ".hg,.git,.svn,*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.o,*.obj,*.exe,*.dll,*.manifest,*.spl,*.sw?,*.DS_Store"
-- }}}

-- Tabs {{{
-- set tab size
vim.o.tabstop = 2
-- set how man columns text gets indented with indent operations
vim.o.shiftwidth = 2
-- dont auto convert tabs into spaces
vim.o.expandtab = true
-- }}}

-- Line Return {{{
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid or when inside an event handler
-- (happens when dropping a file on gvim).
-- Also don't do it when the mark is in the first line, that is the default
-- position when opening a file.
-- TODO this was originally broken into multiple lines but not sure how to do that in lua here
-- augroup line_return
--   au!
--   " When editing a file, always jump to the last known cursor position.
--   " Don't do it when the position is invalid or when inside an event handler
--   " (happens when dropping a file on gvim).
--   " Also don't do it when the mark is in the first line, that is the default
--   " position when opening a file.
--   au BufReadPost *
--   \ if line("'\"") > 1 && line("'\"") <= line("$") |
--   \   exe "normal! g`\"" |
--   \ endif
-- augroup end
vim.api.nvim_exec([[
  augroup Terminal
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup end
]], false)
-- }}}

-- Folding {{{
vim.o.foldlevelstart = 2
vim.o.foldopen = "insert,jump,mark,percent,tag,search"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- tab to toggle foldes
vim.api.nvim_set_keymap('n', '<Tab>', [[@=(foldlevel('.')?'za':"]]..t'<Tab>'..'")'..t'<CR>', { noremap = true })
-- " create fold with tab
vim.api.nvim_set_keymap('v', '<Tab>', 'zf', { noremap = true })

-- "Refocus" folds
vim.api.nvim_set_keymap('n', ',z', 'zMzvzz', { noremap = true })
-- output fold level after chage
vim.api.nvim_set_keymap('n', 'zr', 'zr:echo &foldlevel<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'zm', 'zm:echo &foldlevel<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'zR', 'zR:echo &foldlevel<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'zM', 'zM:echo &foldlevel<cr>', { noremap = true })

-- TODO
-- _G.MyFoldText2 = function()
--   local line = vim.fn.getline('v:foldstart')
--   local nucolwidth = vim.api.nvim_get_vvar('fdc') + vim.api.nvim_get_vvar('number') * vim.api.nvim_get_vvar('numberwidth')
-- end

-- }}}

-- Color Scheme {{{
-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd[[colorscheme palenight]]
-- }}}

-- Commands {{{
-- Count {{{
vim.cmd([[command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``]])
-- }}}
-- }}}

-- Mappings {{{
-- toggle relative / normal line numbers
vim.api.nvim_set_keymap('n', t'<silent>'..t'<C-n>', ':set relativenumber!'..t'<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<leader>'..'jt', t'<Esc>'..':%!python -m json.tool'..t'<CR>', { })
-- Tabs {{{
vim.api.nvim_set_keymap('n', t'<Leader>'..'tt', ':tabnew'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'te', ':tabedit', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'tc', ':tabclose'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'to', ':tabonly'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'tn', ':tabnext'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'tp', ':tabprevious'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'tf', ':tabfirst'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'tl', ':tablast'..t'<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', t'<Leader>'..'tm', ':tabmove', { noremap = true })
-- }}}
-- }}}

-- TODO
vim.cmd([[au VimLeave * set guicursor=a:hor20-Cursor/lCursor-blinkon1]])
vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
