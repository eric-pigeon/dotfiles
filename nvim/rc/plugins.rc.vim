" vim: foldmethod=marker

" indentLine {{{
nnoremap <Leader>ig :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
let g:indentLine_char = '¦' "'┊'
let g:indentLine_color_term = 239
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'start*']
let g:indentLine_fileTypeExclude = ['text']
" }}}
