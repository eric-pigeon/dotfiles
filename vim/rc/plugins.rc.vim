if neobundle#tap('unite.vim') " {{{

  nnoremap [unite] <nop>
  nmap <space> [unite]

   nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
   nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr>
   nnoremap <silent> [unite]z :<C-u>Unite fold<cr>
   nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
   nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
   nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
   nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
   nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
   nnoremap <silent> [unite]t :<C-u>Unite -no-split tig<CR>
   nnoremap <silent> [unite]ta :<C-u>Unite -no-split tig -auto-preview<CR>
   "nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/git<cr>
endif " }}}

if neobundle#tap('vim-rspec') "{{{
  map <Leader>rt :call RunCurrentSpecFile()<CR>
  map <Leader>rs :call RunNearestSpec()<CR>
  map <Leader>rl :call RunLastSpec()<CR>
  map <Leader>ra :call RunAllSpecs()<CR>

  let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
endif " }}}

if neobundle#tap('vim-easy-align') " {{{
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif " }}}
