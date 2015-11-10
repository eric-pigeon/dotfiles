" vim: foldmethod=marker

" Preamle ---------------------------------------------------------------------- {{{
if has('vim_starting')
  set nocompatible
  set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
" }}}

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

" NeoBundle auto-installation and setup ---------------------------------------- {{{

" Install and configure NeoBundle {{{
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  silent !curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
endif

call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" Vimproc to asynchronously run commands (NeoBundle, Unite) {{{
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
" }}}

call s:source_rc('neobundle.rc.vim')

call s:source_rc('plugins.rc.vim')

" Auto install the plugins {{{
call neobundle#end()
" Check if all of the plugins are already installed, in other case ask if we want to install them
NeoBundleCheck
" }}}


let g:unite_source_rec_async_command=
  \ ['ag', '--nocolor', '--nogroup', '--ignore', '".hg"', '--ignore', '".svn"',
  \ '--ignore', '".git"', '--ignore', '".bzr"', '--hidden', '-g', '']
call unite#custom#source('file_rec/async', 'ignore_pattern', '\.sass-cache/\|tmp/')
call unite#filters#matcher_default#use(['matcher_fuzzy']) " use fuzzy search by default
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
  \ 'start_insert': 1,
  \ 'direction': 'botright'
  \ })

" }}}

call s:source_rc('functions.rc.vim')


" Basic Settings --------------------------------------------------------------- {{{
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin on
filetype indent on

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

let mapleader="\\"                                " set leader
set textwidth=0                                   " don't wrap text
set colorcolumn=80
set autoindent                                    " set automatic indentingset automatic indenting
set history=50                                    " keep 50 lines of command line history
set nowrap                                        " turn off line wrapping.
set showcmd                                       " displays incomplete commands
set noshowmode                                    " don't diplay mode (powerline does it better)
set backspace=indent,eol,start                    " allow backspacing over everything in insert mode
set hidden                                        " handle multiple buffers better.
set number
set relativenumber                                " display relative line numbers
set ruler                                         " show the cursor position all the time
set cursorline                                    " highlight current line
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=235 guibg=#222222
autocmd WinEnter * setlocal cursorline            " Show current line highlight when entering a window
autocmd WinLeave * setlocal nocursorline          " Remove current line highlight when leaving a window
" This unsets the last search pattern register by hitting return
set title                                         " change terminals title
set visualbell                                    " no beeping.
set laststatus=2                                  " show the status line all the time
set background=dark
au FocusLost * :wa                                " Automatically save files when they lose focus
au VimResized * :wincmd =                         " Resize splits when the window is resized
set pastetoggle=<f2>
set list
" set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" set listchars=tab:│┈ ,eol:¬,extends:❯,precedes:❮
set listchars=tab:┊\ ,eol:¬,extends:❯,precedes:❮

" }}}

" WildMenu Completion ---------------------------------------------------------- {{{
set wildmenu                                      " enhanced command line completion.
set wildmode=list:longest,list:full                " complete files like a shell.
set wildignore+=.hg,.git,.svn                     " Version control
set wildignore+=*.aux,*.out,*.toc                 " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  " compiled object files
set wildignore+=*.spl                             " compiled spelling word lists
set wildignore+=*.sw?                             " Vim swap files
set wildignore+=*.DS_Store                        " OSX bullshit
" }}}

" Line Return ------------------------------------------------------------------ {{{
augroup line_return
  au!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
augroup end
" }}}

" Tabs ------------------------------------------------------------------------- {{{
set tabstop=2                                     " set tab size
set shiftwidth=2                                  " set how man columns text gets indented with indent operations
set expandtab                                     " dont auto convert tabs into spaces
" }}}

" Backups/Swap Files/Undo File ------------------------------------------------- {{{
set nobackup                                      " don't make a backup before overwritting a file.
set nowritebackup                                 " and again.
set undofile                                      " persistent undo
set undoreload=10000
set directory=$HOME/.vim/tmp/swap//               " keep swap files in one location
set undodir=$HOME/.vim/tmp/undo//                 " undo files location
set backupdir=$HOME/.vim/tmp/backup//             " backups location
" }}}

" Searching and Movement ------------------------------------------------------- {{{
set ignorecase                                    " Case-insensitive searching
set smartcase                                     " Search case-insensitive when search string is all-lowercase,
                                                  " otherwise search case-sensitive
set incsearch                                     " do incremental searching
set hlsearch                                      " highlight matches
set showmatch
set scrolloff=4                                   " Lines of context around the cursor.
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block
" Highlight current word matches
autocmd CursorMoved * silent! exe printf('match SpellLocal /\<%s\>/', expand('<cword>'))
" }}}

" DiffOrig --------------------------------------------------------------------- {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif
" }}}

" Mappings --------------------------------------------------------------------- {{{
" toggle relative / normal line numbers
nnoremap <silent><C-n> :set relativenumber!<cr>
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>
nnoremap <Leader>ud :GundoToggle<CR>
" Tabs ------------------------------------------------------------------------- {{{
map <Leader>tt :tabnew<cr>
map <Leader>te :tabedit
map <Leader>tc :tabclose<cr>
map <Leader>to :tabonly<cr>
map <Leader>tn :tabnext<cr>
map <Leader>tp :tabprevious<cr>
map <Leader>tf :tabfirst<cr>
map <Leader>tl :tablast<cr>
map <Leader>tm :tabmove
" }}}
" }}}

" Folding ---------------------------------------------------------------------- {{{
set foldlevelstart=1
set foldopen=insert,jump,mark,percent,tag,search

" tab to toggle foldes
nnoremap <silent> <Tab> @=(foldlevel('.')?'za':"\<Tab>")<CR>
" create fold with tab
vnoremap <Tab> zf

" "Refocus" folds
nnoremap ,z zMzvzz
" output fold level after chage
nnoremap zr zr:echo &foldlevel<cr>
nnoremap zm zm:echo &foldlevel<cr>
nnoremap zR zR:echo &foldlevel<cr>
nnoremap zM zM:echo &foldlevel<cr>

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" FileType Specific ------------------------------------------------------------ {{{
au FileType c,cpp,java,php,js set cindent
autocmd BufNewFile,BufRead *.swift setfiletype swift
autocmd BufRead * call s:Swift()
function! s:Swift()
  if !empty(&filetype)
    return
  endif

  let line = getline(1)
  if line =~ "^#!.*swift"
    setfiletype swift
  endif
endfunction
augroup ft_swift
  au!
    au FileType swift setlocal expandtab
augroup END
" Ruby {{{
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
au BufNewFile,BufRead *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby foldmethod=syntax
" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake         set filetype=ruby
" IRB config
au BufNewFile,BufRead .irbrc,irbrc               set filetype=ruby
" Rackup
au BufNewFile,BufRead *.ru                       set filetype=ruby
" Capistrano
au BufNewFile,BufRead Capfile                    set filetype=ruby
" Bundler
au BufNewFile,BufRead Gemfile                    set filetype=ruby
" Autotest
au BufNewFile,BufRead .autotest                  set filetype=ruby
" eRuby
au BufNewFile,BufRead *.erb,*.rhtml              set filetype=eruby
" }}}
" PHP {{{
augroup ft_php
  au!
    au FileType php setlocal foldmethod=marker
augroup END
" }}}
" conf {{{
augroup ft_conf
  au!
    au FileType conf setlocal expandtab
    au FileType conf setlocal tabstop=4
    au FileType conf setlocal shiftwidth=4
augroup END
" }}}
" Javascript/Json {{{
augroup ft_javascript
  au!
  " au BufNewFile,BufRead *.js set filetype=javascript syntax=jquery
    au BufNewFile,BufRead *.js.erb set filetype=javascript
    au BufNewFile,BufRead *.json set filetype=javascript
    au FileType javascript call JavaScriptFold()
augroup end
" }}}
" Yacc {{{
augroup ft_yacc
  au!
    au BufNewfile,BufRead *ypp set filetype=yacc
augroup end
" }}}
" Bash {{{
augroup ft_bash
  au!
    au FileType sh setlocal foldmethod=marker
augroup END
" }}}
" tmux {{{
augroup ft_tmux
  au!
    au FileType tmux setlocal foldmethod=marker
augroup END
" }}}
" }}}

" Color Scheme ----------------------------------------------------------------- {{{
colorscheme harlem-nights
" }}}

" Plugin Settings -------------------------------------------------------------- {{{
" Local vimrc {{{
let g:localvimrc_ask=0                        " dont ask to source local vim rcs
" }}}
" }}}

" Environments (GUI/Consoloe) -------------------------------------------------- {{{
if has('gui_running')
else
  " In many terminal emulators the mouse works just fine, thus enable it.
  if has('mouse')
    set mouse=a
  endif
endif
" }}}

"set tags+=gems.tags
