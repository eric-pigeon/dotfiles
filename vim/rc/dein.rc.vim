" vim: foldmethod=marker

if dein#load_state('/Users/epigeon/.cache/dein')
  call dein#begin('/Users/epigeon/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/epigeon/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Denite {{{
  call dein#add('Shougo/denite.nvim')
  " }}}
  
  " call dein#add('lifepillar/pgsql.vim')
  
  " Global {{{
  " call dein#add('elmcast/elm-vim')
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
  " }}}
  
  " Erlang {{{
  " call dein#add('jimenezrick/vimerl',      {'lazy': 1, 'on_ft': 'erlang'})
  " call dein#add('vim-erlang/vim-dialyzer', {'lazy': 1, 'on_ft': 'erlang'})
  " }}}
  
  " Elixir {{{
  " call dein#add('elixir-lang/vim-elixir', {'lazy':1, 'on_ft': 'elixir'})
  " }}}
  
  " GO {{{
  " call dein#add('fatih/vim-go', {'lazy':1, 'on_ft': 'go'})
  " }}}
  
  " Swift {{{
  " call dein#add('Keithbsmiley/swift.vim', {'lazy': 1, 'on_ft': 'swift'})
  " }}}
  
  " Markdown {{{
  " call dein#add('nelstrom/vim-markdown-folding', {'lazy': 1, 'on_ft': 'markdown'})
  " }}}
  
  " Python {{{
  " call dein#add('tmhedberg/SimpylFold',                 {'lazy': 1, 'on_ft': 'python'})       " Fold Python source code
  " call dein#add('davidhalter/jedi-vim',                 {'lazy': 1, 'on_ft': 'python'})       " Python autocompletion
  " call dein#add('JarrodCTaylor/vim-python-test-runner', {'lazy': 1, 'on_ft': 'python'})       " Run Python tests from Vim
  " }}}
  
  " Javascript {{{
  " call dein#add('isRuslan/vim-es6', {'lazy': 1, 'on_ft': 'javascript'})
  " call dein#add('kern/vim-es7', {'lazy': 1, 'on_ft': 'javascript'})
  " }}}
  
  " call dein#add('timburgess/extempore.vim')
  
  " call dein#add('chr4/nginx.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

