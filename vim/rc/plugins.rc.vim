" vim: foldmethod=marker

if neobundle#tap('nerdtree') " {{{
  let g:NERDTreeWinSize = 40
  let g:NERDTreeShowHidden=1
  let g:NERDTreeQuitOnOpen=0
  let g:NERDTreeShowLineNumbers=1
  let g:NERDTreeChDirMode=0
  let g:NERDTreeShowBookmarks=1
  let g:NERDTreeIgnore=['\.git','\.hg','\.pyc$']
  "let NERDTreeBookmarksFile=s:get_cache_dir('NERDTreeBookmarks')
  nnoremap <Leader>nt :NERDTreeToggle<CR>
  nnoremap <Leader>no :NERDTreeFind<CR>
endif " }}}

if neobundle#tap('unite.vim') " {{{

  nnoremap [unite] <nop>
  nmap <space> [unite]

   nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
   nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr>
   nnoremap <silent> [unite]z :<C-u>Unite fold<cr>
   "nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
   nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
   nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
   nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
   nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
   nnoremap <silent> [unite]g :<C-u>Unite bundler<cr>
   "nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/git<cr>
endif " }}}

if neobundle#tap('vim-rspec') "{{{
  map <Leader>rt :call RunCurrentSpecFile()<CR>
  map <Leader>rs :call RunNearestSpec()<CR>
  map <Leader>rl :call RunLastSpec()<CR>
  map <Leader>ra :call RunAllSpecs()<CR>

  if neobundle#tap('tslime.vim') "{{{
    let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
    let g:tslime_always_current_session = 1
  endif " }}}
endif " }}}

if neobundle#tap('vim-easy-align') " {{{
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif " }}}

if neobundle#tap('vim-sneak') " {{{
  nmap f <Plug>SneakForward
  nmap F <Plug>SneakBackward
  let g:sneak#streak = 1
endif " }}}

if neobundle#tap('indentLine') " {{{
  nnoremap <Leader>ig :IndentLinesToggle<CR>
  let g:indentLine_enabled = 0
  let g:indentLine_char = '¦' "'┊'
  let g:indentLine_color_term = 239
  let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'start*']
  let g:indentLine_fileTypeExclude = ['text']
endif " }}}

if neobundle#tap('gundo') " {{{
  nnoremap <Leader>ud :GundoToggle<CR>
endif " }}}

if neobundle#tap('vim-airline') " {{{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep=' '
  let g:airline#extensions#tabline#left_alt_sep='¦'
endif " }}}
