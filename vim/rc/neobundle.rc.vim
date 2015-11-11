" vim: foldmethod=marker

" Unite {{{
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Kocha/vim-unite-tig'
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'tsukkee/unite-tag'
NeoBundle 'kopischke/unite-spell-suggest'                                                          " Allows spell check to use the unite plugin for finding suggestions
NeoBundleLazy 'Shougo/neomru.vim',         {'autoload':{'unite_sources': ['file_mru', 'directory_mru']}} " Allows unite to create a list of mru files
NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload': {'unite_sources': 'colorscheme'}}                " Allows unite to auto switch between colorschemes
NeoBundleLazy 'osyo-manga/unite-fold',     {'autoload': {'unite_sources': 'fold'}}                       " Allows unite to get a list of folds in the current buffer
" }}}

" Global {{{
NeoBundleLazy 'evanmiller/nginx-vim-syntax'
NeoBundle 'wellle/tmux-complete.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/neocomplete.vim'                                                                 " Auto completion framework. Requires that vim be compiled with lua support
NeoBundle 'Raimondi/delimitMate'                                                                   " Auto close quotes, parens, brackets, etc
NeoBundle 'majutsushi/tagbar'                                                                      " Display tags in a buffer ordered by class
NeoBundle 'ervandew/supertab'                                                                      " Use tab for all completions
NeoBundle 'scrooloose/syntastic'                                                                   " Syntax checking
NeoBundle 'sjl/gundo.vim'                                                                          " Visual undo
NeoBundle 'junegunn/vim-easy-align'                                                                " Simple easy to use alignment plugin
NeoBundle 'Yggdroot/indentLine'                                                                    " Indent guides
NeoBundle 'takac/vim-hardtime'                                                                     " Muhahahahaha oh their faces. I can taste their tears
NeoBundle 'tell-k/vim-browsereload-mac'
"NeoBundle 'vim-scripts/UltiSnips'                                                                  " Ultimate solution for snippets
"NeoBundle 'tpope/vim-commentary'                                                                   " Comment stuff out
"NeoBundle 'tpope/vim-surround'                                                                     " Surround objects with all manor of things
"NeoBundle 'justinmk/vim-sneak'                                                                     " Vim motion plugin
"NeoBundle 'JarrodCTaylor/vim-shell-executor'                                                       " Execute any code from within vim buffers
"NeoBundle 'mattn/emmet-vim/'                                                                       " Formally zen coding
"NeoBundle 'osyo-manga/vim-over'                                                                    " Visual find and replace
"NeoBundle 'wellle/targets.vim'                                                                     " Provide additional text objects
"NeoBundle 'tpope/vim-fireplace'                                                                    " Clojure REPL support
"NeoBundle 'thinca/vim-qfreplace'                                                                   " Easy replace in the quick fix buffer
"NeoBundle 'guns/vim-sexp'                                                                          " Precision editing for S-expressions
"NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'                                             " Make sexp usable
NeoBundle 'mhinz/vim-hugefile'
" }}}

" NerdTree {{{
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'xxxpigeonxxx/nerdtree-ag'
" }}}

" Ruby {{{
NeoBundle 'vim-ruby/vim-ruby',    {'autoload':{'filetypes':['ruby']}}
NeoBundle 'thoughtbot/vim-rspec', {'autoload':{'filetypes':['ruby']}}
NeoBundle 'jgdavey/tslime.vim',   {'autoload':{'filetypes':['ruby']}}
NeoBundle 'bruno-/vim-ruby-fold'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'sorah/unite-bundler'
" }}}

" Swift {{{
NeoBundleLazy 'Keithbsmiley/swift.vim', {'autoload': {'filetypes': ['swift']}}
" }}}

" Elixir {{{
NeoBundle 'elixir-lang/vim-elixir', {'autoload':{'filetypes':['elixir']}}
" }}}

" Erlang {{{
NeoBundleLazy 'jimenezrick/vimerl',      {'autoload':{'filetypes':['erlang']}}
NeoBundleLazy 'vim-erlang/vim-dialyzer', {'autoload':{'filetypes':['erlang']}}
" }}}

" Python {{{
NeoBundleLazy 'tmhedberg/SimpylFold',                 {'autoload':{'filetypes':['python']}}        " Fold Python source code
NeoBundleLazy 'davidhalter/jedi-vim',                 {'autoload':{'filetypes':['python']}}        " Python autocompletion
NeoBundleLazy 'JarrodCTaylor/vim-python-test-runner', {'autoload':{'filetypes':['python']}}        " Run Python tests from Vim
" }}}

" Javascript {{{
"NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}            " Improved indentation and syntax support
NeoBundleLazy 'isRuslan/vim-es6', {'autoload':{'filetypes':['javascript']}}            " Improved indentation and syntax support
" }}}

" Markdown {{{
NeoBundleLazy 'nelstrom/vim-markdown-folding', {'autoload':{'filetypes':['markdown']}}             " Does what it says on the tin
"NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}                        " Syntax highlighting for markdown (Perhaps optional with new versions of Vim)
" }}}

" YAML {{{
NeoBundleLazy 'avakhov/vim-yaml'
" }}}

" Color Schemes {{{
NeoBundle 'JarrodCTaylor/vim-256-color-schemes'                                                    " A variety of terminal based colorschemes
NeoBundle 'altercation/vim-colors-solarized'
" }}
