" vim: foldmethod=marker

" indentLine {{{
nnoremap <Leader>ig :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
let g:indentLine_char = '¦' "'┊'
let g:indentLine_color_term = 239
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'start*']
let g:indentLine_fileTypeExclude = ['text']
" }}}

" crease.vim {{{
set foldlevelstart=0
set foldmarker=\ {{{,\ }}}

" 'space' is fold char ↓
set fillchars=fold:\ 

function! FoldIsCommented()  " {{{
  " 2020-09-12: Converted to lua for adequate performance
  return luaeval("require('fold').foldIsCommented()")
endfunction  " }}}

function! IsMod() " {{{
  if exists('g:loaded_gitgutter')
    return gitgutter#fold#is_changed() ? g:modified_label  : ' '
  else
    return ''
  endif
endfunction " }}}

function! CreaseIndent() abort    " {{{
  let fs = nextnonblank(v:foldstart)    
  let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')  
  let foldLevelStr = repeat(' ', match(line,'\S'))  
  return foldLevelStr    
endfunction    " }}}
" }}}

function! CountFoldText() abort   " {{{
  let foldCnt = luaeval("require('fold').countChildFolds()")
  if l:foldCnt < 0 
    return '' 
  endif
  return l:foldCnt == 0 ? '' : '' . l:foldCnt . " " . g:fold_label . ' · '
endfunction   " }}}

function! Cmmtd() abort " {{{
  return FoldIsCommented() ? g:commented_label : ''
endfunction " }}}

function! FoldTxt() abort " {{{
  return trim(substitute(
	\ getline(v:foldstart),
	\ '\V\C'
	\ . join(split(&commentstring, '%s'), '\|') . '\|'
	\ . join(split(&foldmarker, ','), '\d\?\|') . '\|'
	\ . join(g:foldtext_stop_words, '\|') . '\|',
	\ '',
	\ 'g'
	\ ))
endfunction " }}}
" }}}

let g:fold_label = ' '
let g:commented_label = ' '
let g:lines_label = 'lines'
let g:modified_label = ' ' " alt : ' '

let g:foldtext_stop_words = [
      \ '\^function',
      \ '!',
      \ 'abort',
      \ ]

let g:crease_foldtext = {  
      \ 'default': '%{CreaseIndent()}%{FoldTxt()} %{IsMod()} %{Cmmtd()} %= %{CountFoldText()}%l '.g:lines_label.' %f%f%f%f',
      \}
" }}}
