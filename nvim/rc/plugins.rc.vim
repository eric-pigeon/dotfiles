" vim: foldmethod=marker

" FZF {{{
nnoremap [fzf] <nop>
nmap <space> [fzf]

function! s:get_ag_text()
  let text = input('Search Text: ', '')
  execute 'Ag ' .text
endfunction

nnoremap <silent> [fzf]f       :Files<cr>
nnoremap <silent> [fzf]l       :Lines<cr>
nnoremap <silent> [fzf]d       :Directories<cr>
nnoremap <silent> [fzf]b       :Buffers<cr>
nnoremap <silent> [fzf]s       :<C-u>call <SID>get_ag_text()<cr>
" nnoremap <silent> [fzf]b       :<C-u>call fzf#run({'source': map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'), 'sink': 'e', 'down': '30%', 'window': 'call FloatingFZF()'})<cr>

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF(0.9, 0.6, "Comment")' }

sign define Ag text=Ag
function! Test()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&nu', 0)
  call setbufvar(buf, '&rnu', 0)
  " call setbufvar(buf, '&signcolumn', 'no')
  execute "sign place 1 line=1 name=Ag buffer=".buf

  let height = 1
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)
  let row = &lines * 2 / 10

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

function! FloatingFZF(width, height, border_highlight)
  " let width = float2nr(&columns - (&columns * 2 / 10))
  let width = float2nr(&columns * a:width)
  " let height = &lines * 6 / 10
  let height = float2nr(&lines * a:height)
  " let row = &lines * 2 / 10
  let row = float2nr((&lines - height) / 2)
  " let col = float2nr((&columns - width) / 2)
  let col = float2nr((&columns - width) / 2)
  let top = '┌' . repeat('─', width - 2) . '┐'
  let mid = '│' . repeat(' ', width - 2) . '│'
  let bot = '└' . repeat('─', width - 2) . '┘'
  let border = [top] + repeat([mid], height - 2) + [bot]

  if has('nvim')
    let frame = s:create_float(a:border_highlight, {
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ })
    call nvim_buf_set_lines(frame, 0, -1, v:true, border)
    call s:create_float('Normal', {
        \ 'row': row + 1,
        \ 'col': col + 2,
        \ 'width': width - 4,
        \ 'height': height - 2,
        \ })
    exe 'au BufWipeout <buffer> bw '..frame
  else
    let frame = s:create_popup_window(a:border_highlight, {
        \ 'line': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'is_frame': 1,
        \ })
    call setbufline(frame, 1, border)
    call s:create_popup_window('Normal', {
        \ 'line': row + 1,
        \ 'col': col + 2,
        \ 'width': width - 4,
        \ 'height': height - 2,
        \ })
  endif
endfunction
au FileType fzf set nonu nornu

fu s:create_float(hl, opts) abort
  let buf = nvim_create_buf(v:false, v:true)
  " call setbufvar(buf, '&signcolumn', 'no')
  let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:'..a:hl)
  return buf
endfu

fu s:create_popup_window(hl, opts) abort
    if has_key(a:opts, 'is_frame')
        let id = popup_create('', #{
            \ line: a:opts.line,
            \ col: a:opts.col,
            \ minwidth: a:opts.width,
            \ minheight: a:opts.height,
            \ zindex: 50,
            \ })
        call setwinvar(id, '&wincolor', a:hl)
        exe 'au BufWipeout * ++once call popup_close('..id..')'
        return winbufnr(id)
    else
        let buf = term_start(&shell, #{hidden: 1})
        call popup_create(buf, #{
            \ line: a:opts.line,
            \ col: a:opts.col,
            \ minwidth: a:opts.width,
            \ minheight: a:opts.height,
            \ zindex: 51,
            \ })
        exe 'au BufWipeout * ++once bw! '..buf
    endif
endfu

" }}}

" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

" indentLine {{{
nnoremap <Leader>ig :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
let g:indentLine_char = '¦' "'┊'
let g:indentLine_color_term = 239
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'start*']
let g:indentLine_fileTypeExclude = ['text']
" }}}

" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='¦'
let g:airline#extensions#whitespace#skip_indent_check_ft =
   \  {'go': ['mixed-indent-file']}
" }}}

" coc {{{
" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" }}}
