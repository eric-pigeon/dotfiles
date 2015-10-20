" vim: foldmethod=marker

NeoBundle 'bling/vim-airline' "{{{
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_sep=' '
	let g:airline#extensions#tabline#left_alt_sep='¦'
"}}}

NeoBundle 'scrooloose/nerdtree' "{{{
	let NERDTreeShowHidden=1
	let NERDTreeQuitOnOpen=0
	let NERDTreeShowLineNumbers=1
	let NERDTreeChDirMode=0
	let NERDTreeShowBookmarks=1
	let NERDTreeIgnore=['\.git','\.hg','\.pyc$']
	nnoremap <Leader>nt :NERDTreeToggle<CR>
	nnoremap <Leader>no :NERDTreeFind<CR>
"let NERDTreeBookmarksFile=s:get_cache_dir('NERDTreeBookmarks')
" }}}

" Unite {{{
NeoBundle 'Shougo/unite.vim' "{{{
NeoBundleLazy 'Kocha/vim-unite-tig'
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'tsukkee/unite-tag'
NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources': ['file_mru', 'directory_mru']}}   " Allows unite to create a list of mru files
" }}}
" }}}

" Swift {{{
NeoBundleLazy 'Keithbsmiley/swift.vim', {'autoload': {'filetypes': ['swift']}}
" }}}

NeoBundleLazy 'evanmiller/nginx-vim-syntax'
NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload': {'unite_sources': 'colorscheme'}}          " Allows unite to auto switch between colorschemes
NeoBundleLazy 'osyo-manga/unite-fold', {'autoload': {'unite_sources': 'fold'}}                     " Allows unite to get a list of folds in the current buffer
" NeoBundle 'mileszs/ack.vim'
" NeoBundle 'vim-scripts/nerdtree-ack'
NeoBundle 'rking/ag.vim'
NeoBundle 'taiansu/nerdtree-ag'
NeoBundle 'kopischke/unite-spell-suggest'                                                          " Allows spell check to use the unite plugin for finding suggestions
NeoBundle 'Shougo/neocomplete.vim'                                                                 " Auto completion framework. Requires that vim be compiled with lua support
NeoBundle 'Raimondi/delimitMate'                                                                   " Auto close quotes, parens, brackets, etc
NeoBundle 'JarrodCTaylor/vim-256-color-schemes'                                                    " A variety of terminal based colorschemes
NeoBundle 'majutsushi/tagbar'                                                                      " Display tags in a buffer ordered by class
NeoBundle 'ervandew/supertab'                                                                      " Use tab for all completions
NeoBundle 'scrooloose/syntastic'                                                                   " Syntax checking
NeoBundle 'vim-scripts/UltiSnips'                                                                  " Ultimate solution for snippets
NeoBundle 'tpope/vim-commentary'                                                                   " Comment stuff out
NeoBundle 'mhinz/vim-startify'                                                                     " Fancy splash screen
NeoBundle 'tpope/vim-surround'                                                                     " Surround objects with all manor of things
NeoBundle 'sjl/gundo.vim'                                                                          " Visual undo
NeoBundle 'justinmk/vim-sneak'                                                                     " Vim motion plugin
NeoBundle 'JarrodCTaylor/vim-shell-executor'                                                       " Execute any code from within vim buffers
NeoBundle 'mattn/emmet-vim/'                                                                       " Formally zen coding
NeoBundle 'junegunn/vim-easy-align'                                                                " Simple easy to use alignment plugin
NeoBundle 'osyo-manga/vim-over'                                                                    " Visual find and replace
NeoBundle 'Yggdroot/indentLine'                                                                    " Indent guides
NeoBundle 'wellle/targets.vim'                                                                     " Provide additional text objects
NeoBundle 'tpope/vim-fireplace'                                                                    " Clojure REPL support
NeoBundle 'thinca/vim-qfreplace'                                                                   " Easy replace in the quick fix buffer
NeoBundle 'guns/vim-sexp'                                                                          " Precision editing for S-expressions
NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'                                             " Make sexp usable
NeoBundle 'amdt/vim-niji'                                                                          " Rainbow parentheses
NeoBundle 'tpope/vim-dispatch'                                                                     " Asynchronous build and test dispatcher
NeoBundle 'takac/vim-hardtime'                                                                     " Muhahahahaha oh their faces. I can taste their tears
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle '~/dotfiles/vim/my-plugins/vim-grep-quickfix', {'type': 'nosync'}                        " Add grep functionality to the quickfix buffer
NeoBundle '~/dotfiles/vim/my-plugins/vim-wiki-links', {'type': 'nosync'}                           " Add the ability to link between wiki (markdown) files
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tell-k/vim-browsereload-mac'
" Ruby {{{
NeoBundle 'vim-ruby/vim-ruby',    {'autoload':{'filetypes':['ruby']}}
NeoBundle 'thoughtbot/vim-rspec', {'autoload':{'filetypes':['ruby']}}
NeoBundle 'jgdavey/tslime.vim',   {'autoload':{'filetypes':['ruby']}}
NeoBundle 'bruno-/vim-ruby-fold'
" }}}

" Erlang {{{
NeoBundleLazy 'jimenezrick/vimerl', {'autoload':{'filetypes':['erlang']}}
NeoBundleLazy 'vim-erlang/vim-dialyzer', {'autoload':{'filetypes':['erlang']}}
" }}}

" Python Plugins {{{
NeoBundleLazy 'tmhedberg/SimpylFold',                 {'autoload':{'filetypes':['python']}}        " Fold Python source code
NeoBundleLazy 'davidhalter/jedi-vim',                 {'autoload':{'filetypes':['python']}}        " Python autocompletion
NeoBundleLazy 'JarrodCTaylor/vim-python-test-runner', {'autoload':{'filetypes':['python']}}        " Run Python tests from Vim
" }}}

" Javascript / CoffeeScript {{{
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}            " Improved indentation and syntax support
NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload':{'filetypes':['javascript','coffee']}}       " CoffeeScript support syntax, indenting, etc
NeoBundleLazy 'JarrodCTaylor/vim-js2coffee', {'autoload':{'filetypes':['javascript','coffee']}}    " Convert JS to CoffeeScript and vice versa
NeoBundleLazy 'lukaszkorecki/CoffeeTags', {'autoload':{'filetypes':['javascript','coffee']}}       " Ctags generator for CoffeScript
" }}}

" Markdown {{{
NeoBundleLazy 'nelstrom/vim-markdown-folding', {'autoload':{'filetypes':['markdown']}}             " Does what it says on the tin
NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}                        " Syntax highlighting for markdown (Perhaps optional with new versions of Vim)
" }}}
