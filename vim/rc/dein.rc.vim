" vim: foldmethod=marker

" Denite {{{
call dein#add('Shougo/denite.nvim')
" }}}

call dein#add('Shougo/vimproc.vim', {'build': 'make'})
" Unite {{{
" call dein#add('Shougo/unite.vim')
" call dein#add('kopischke/unite-spell-suggest') " Allows spell check to use the unite plugin for finding suggestions
" call dein#add('Shougo/neomru.vim')             " Allows unite to create a list of mru files
" call dein#add('ujihisa/unite-colorscheme')     " Allows unite to auto switch between colorschemes
" call dein#add('Kocha/vim-unite-tig')
" call dein#add('osyo-manga/unite-fold')
" call dein#add('Shougo/unite-outline')
" }}}

" Global {{{
call dein#add('Shougo/neocomplete.vim')
call dein#add('bkad/CamelCaseMotion', {
      \ 'hook_post_source': "call camelcasemotion#CreateMotionMappings('<leader>')"
      \ })
call dein#add('Shougo/deoplete.nvim', {
      \ 'if': has('nvim'),
      \ 'on_i': 1,
      \ 'hook_source': 'let g:deoplete#enable_at_startup = 1'
      \ })
" TODO not global
call dein#add('elzr/vim-json')
call dein#add('Konfekt/FastFold')
call dein#add('bling/vim-airline')
call dein#add('scrooloose/syntastic')    " Syntax checking
call dein#add('junegunn/vim-easy-align') " Simple easy to use alignment plugin
call dein#add('sjl/gundo.vim')           " Visual undo
call dein#add('mhinz/vim-hugefile')
call dein#add('Yggdroot/indentLine')
call dein#add('ervandew/supertab')
call dein#add('majutsushi/tagbar')       " Display tags in a buffer ordered by class
call dein#add('rking/ag.vim')
call dein#add('Raimondi/delimitMate')    " Auto close quotes, parens, brackets, etc
call dein#add('tell-k/vim-browsereload-mac')
" }}}

" Ruby {{{
call dein#add('vim-ruby/vim-ruby', {
      \ 'lazy': 1,
      \ 'on_ft': 'ruby'
      \ })
call dein#add('tpope/vim-rails', {
      \ 'lazy': 1,
      \ 'on_ft': 'ruby'
      \ })
call dein#add('thoughtbot/vim-rspec', {
      \ 'lazy': 1,
      \ 'on_ft': 'ruby'
      \ })
call dein#add('jgdavey/tslime.vim', {
      \ 'lazy': 1,
      \ 'on_ft': 'ruby'
      \ })
call dein#add('bruno-/vim-ruby-fold', {
      \ 'lazy': 1,
      \ 'on_ft': 'ruby'
      \ })
call dein#add('tpope/vim-bundler')
call dein#add('sorah/unite-bundler')
" }}}

" NerdTree {{{
call dein#add('scrooloose/nerdtree', {'lazy': 1})
call dein#add('xxxpigeonxxx/nerdtree-ag', {'depends': 'nerdtree'})
" }}}

" YAML {{{
call dein#add('avakhov/vim-yaml', {'lazy': 1, 'on_ft': 'yaml'})
" }}}

" Erlang {{{
call dein#add('jimenezrick/vimerl',      {'lazy': 1, 'on_ft': 'erlang'})
call dein#add('vim-erlang/vim-dialyzer', {'lazy': 1, 'on_ft': 'erlang'})
" }}}

" Elixir {{{
call dein#add('elixir-lang/vim-elixir', {'lazy':1, 'on_ft': 'elixir'})
" }}}

" Swift {{{
call dein#add('Keithbsmiley/swift.vim', {'lazy': 1, 'on_ft': 'swift'})
" }}}

" Markdown {{{
call dein#add('nelstrom/vim-markdown-folding', {'lazy': 1, 'on_ft': 'markdown'})
" }}}

" Python {{{
call dein#add('tmhedberg/SimpylFold',                 {'lazy': 1, 'on_ft': 'python'})       " Fold Python source code
call dein#add('davidhalter/jedi-vim',                 {'lazy': 1, 'on_ft': 'python'})       " Python autocompletion
call dein#add('JarrodCTaylor/vim-python-test-runner', {'lazy': 1, 'on_ft': 'python'})       " Run Python tests from Vim
" }}}

" Javascript {{{
call dein#add('isRuslan/vim-es6', {'lazy': 1, 'on_ft': 'javascript'})
" }}}

" Color Schemes {{{
call dein#add('xxxpigeonxxx/vim-256-color-schemes') " A variety of terminal based colorschemes
call dein#add('altercation/vim-colors-solarized')
" }}}

" Global {{{
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
" }}}
