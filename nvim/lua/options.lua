-- vim: foldmethod=marker

vim.opt.shortmess:append { s = true, I = true } -- disable startup message
vim.opt.backspace:append { "nostop" } -- Don't stop backspace at insert
if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.diffopt:append "linematch:60" -- enable linematch diff algorithm
end

vim.opt.breakindent = true -- Wrap indent to match  line start
vim.opt.clipboard = "unnamedplus" -- Connection to the system clipboard
-- vim.opt.cmdheight = 0 -- hide command line unless needed
vim.opt.completeopt = { "menuone", "noselect" } -- Options for insert mode completion
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.fileencoding = "utf-8" -- File content encoding for the buffer
vim.opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
vim.opt.history = 100 -- Number of commands to remember in a history table
vim.opt.laststatus = 3 -- globalstatus
vim.opt.linebreak = true -- Wrap lines at 'breakat'
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.number = true -- Show number line
vim.opt.relativenumber = true -- Show relative numberline
vim.opt.preserveindent = true -- Preserve indent structure as much as possible
vim.opt.pumheight = 10 -- Height of the pop up menu
vim.opt.scrolloff = 8 -- Number of lines to keep above and below the cursor
vim.opt.showmode = false -- Disable showing modes in command line
vim.opt.showtabline = 2 -- always display tabline
vim.opt.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.smartindent = true -- Smarter autoindentation
vim.opt.splitbelow = true -- Splitting a new window below the current one
vim.opt.splitright = true -- Splitting a new window at the right of the current one
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.opt.timeoutlen = 500 -- Shorten key timeout length a little bit for which-key
vim.opt.undofile = true -- Enable persistent undo
vim.opt.updatetime = 300 -- Length of time to wait before triggering the plugin
vim.opt.undoreload = 10000
vim.opt.virtualedit = "block" -- allow going past end of line in visual block mode
vim.opt.wrap = false -- Disable wrapping of lines longer than the width of window
vim.opt.writebackup = false -- Disable making a backup before overwriting a file

if  vim.fn.has "nvim-0.9" == 1 then
  vim.opt.splitkeep = "screen" -- Maintain code view when splitting
end

-- Folds {{{
vim.opt.foldenable = true -- enable fold for nvim-ufo
vim.opt.foldlevel = 99 -- set high foldlevel for nvim-ufo
vim.opt.foldlevelstart = 99 -- start with all code unfolded
if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.foldcolumn = "1"
end
-- }}}

-- Searching {{{
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.infercase = true -- Infer cases in keyword completion
vim.opt.smartcase = true -- Case sensitivie searching
-- }}}

-- Tabs {{{
vim.opt.expandtab = true -- Enable the use of space in tab
vim.opt.shiftwidth = 2 -- Number of space inserted for indentation
vim.opt.tabstop = 2 -- Number of space in a tab
-- }}}

-- TODO
-- Basic Settings {{{
-- spelling
vim.o.dictionary = "/usr/share/dict/words"
vim.o.thesaurus = "$HOME/.thesaurus"
-- dont wrap text
vim.o.textwidth = 0
-- automatic indenting
vim.o.autoindent = true
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
-- goth mode
vim.o.background = "dark"
--Add map to enter paste mode
-- vim.o.pastetoggle=  "<F2>"
-- special character display
vim.o.list = true
vim.o.listchars = "tab:┊ ,eol:¬,extends:❯,precedes:❮,trail:-,nbsp:+"

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- don't wrap text
vim.wo.wrap = false
--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Show current line highlight when entering a window
vim.cmd([[au WinEnter * setlocal cursorline]])
-- Remove current line highlight when leaving a window
vim.cmd([[au WinLeave * setlocal nocursorline]])
-- Automatically save files when they lose focus
-- vim.cmd([[au FocusLost * :wa]])
-- Resize splits when the window is resized
vim.cmd([[au VimResized * :wincmd =]])
-- }}}



vim.g.mapleader = "\\"
-- local options = astronvim.user_opts("options", {
--   g = {
--     highlighturl_enabled = true, -- highlight URLs by default
--     mapleader = " ", -- set leader key
--     autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
--     codelens_enabled = true, -- enable or disable automatic codelens refreshing for lsp that support it
vim.g.lsp_handlers_enabled = true -- enable or disable default vim.lsp.handlers (hover and signatureHelp)
vim.g.cmp_enabled = true -- enable completion at start
vim.g.autopairs_enabled = true -- enable autopairs at start
vim.g.diagnostics_mode = 3 -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
vim.g.icons_enabled = true -- disable icons in the UI (disable if no nerd font is available)
vim.g.ui_notifications_enabled = true -- disable notifications when toggling UI elements
--   },
--   t = { bufs = vim.api.nvim_list_bufs() }, -- initialize buffers for the current tab
-- })
