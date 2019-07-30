" vim: foldmethod=marker

" Ack.vim {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}

" NerdTree {{{
  let g:NERDTreeWinSize = 40
  let g:NERDTreeShowHidden=1
  let g:NERDTreeQuitOnOpen=0
  let g:NERDTreeShowLineNumbers=1
  let g:NERDTreeChDirMode=0
  let g:NERDTreeShowBookmarks=1
  let g:NERDTreeIgnore=['\.git','\.hg','\.pyc$']
  nnoremap <Leader>nt :NERDTreeToggle<CR>
  nnoremap <Leader>no :NERDTreeFind<CR>
" }}}

" YouCompleteMe {{{
let g:ycm_language_server = [
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ 'node', expand( '$HOME/.vim/lsp/yaml/node_modules/.bin/yaml-language-server' ), '--stdio' ],
  \     'filetypes': [ 'yaml' ],
  \   },
  "\   {
  "\     'name': 'php',
  "\     'cmdline': [ 'php', expand( '$HOME/.vim/lsp/php/vendor/bin/php-language-server.php' ) ],
  "\     'filetypes': [ 'php' ],
  "\   },
  "\   {
  "\     'name': 'json',
  "\     'cmdline': [ 'node', expand( '$HOME/.vim/lsp/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
  "\     'filetypes': [ 'json' ],
  "\   },
  \   {
  \     'name': 'ruby',
  \     'cmdline': [ expand( '$HOME/.vim/lsp/ruby/bin/solargraph' ), 'stdio' ],
  \     'filetypes': [ 'ruby' ],
  \   }
  "\   { 'name': 'kotlin',
  "\     'filetypes': [ 'kotlin' ], 
  "\     'cmdline': [ expand( '$HOME/.vim/lsp/kotlin/server/build/install/server/bin/server' ) ],
  "\   },
  "\   { 'name': 'd',
  "\     'filetypes': [ 'd' ], 
  "\     'cmdline': [ expand( '$HOME/.vim/lsp/d/serve-d' ) ],
  "\   },
  "\   { 'name': 'vue',
  "\     'filetypes': [ 'vue' ], 
  "\     'cmdline': [ expand( '$HOME/.vim/lsp/vue/node_modules/.bin/vls' ) ]
  "\   },
  "\   { 'name': 'docker',
  "\     'filetypes': [ 'dockerfile' ], 
  "\     'cmdline': [ expand( '$HOME/.vim/lsp/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
  "\   },
  "\   { 'name': 'vim',
  "\     'filetypes': [ 'vim' ],
  "\     'cmdline': [ expand( '$HOME/.vim/lsp/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
  "\   },
  "\   { 'name': 'scala',
  "\     'filetypes': [ 'scala' ],
  "\     'cmdline': [ 'metals-vim' ],
  "\     'project_root_files': [ 'build.sbt' ]
  "\   },
  "\   { 'name': 'purescript',
  "\     'filetypes': [ 'purescript' ],
  "\     'cmdline': [ expand( '$HOME/.vim/lsp/viml/node_modules/.bin/purescript-language-server' ), '--stdio' ]
  "\   },
  "\   { 'name': 'fortran',
  "\     'filetypes': [ 'fortran' ],
  "\     'cmdline': [ 'fortls' ],
  "\   },
  "\   { 'name': 'haskell',
  "\     'filetypes': [ 'haskell', 'hs', 'lhs' ],
  "\     'cmdline': [ 'hie-wrapper', '--lsp' ],
  "\     'project_root_files': [ '.stack.yaml', 'cabal.config', 'package.yaml' ]
  "\   },
  "\   { 'name': 'julia',
  "\     'filetypes': [ 'julia' ],
  "\     'project_root_files': [ 'Project.toml' ],
  "\     'cmdline': <See note below>
  "\   }
  \ ]
" }}}

"" Deoplete {{{
"" <TAB>: completion.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ deoplete#manual_complete()
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"" <S-TAB>: completion back.
"inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
"
"inoremap <expr><C-g>       deoplete#refresh()
"inoremap <expr><C-e>       deoplete#cancel_popup()
"inoremap <silent><expr><C-l>       deoplete#complete_common_string()
"
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function() abort
"  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
"endfunction
"
"" cpsm test
"" call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
"" call deoplete#custom#source('_', 'sorters', [])
"
"call deoplete#custom#source('_', 'matchers',
"      \ ['matcher_fuzzy', 'matcher_length'])
"call deoplete#custom#source('denite', 'matchers',
"      \ ['matcher_full_fuzzy', 'matcher_length'])
"" call deoplete#custom#source('eskk,tabnine', 'matchers', [])
"call deoplete#custom#source('eskk', 'matchers', [])
"" call deoplete#custom#source('buffer', 'mark', '')
"" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
"" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
"" call deoplete#custom#source('buffer', 'mark', '*')
"
"call deoplete#custom#option('ignore_sources', {
"      \ '_': ['buffer'],
"      \ 'help': ['tabnine'],
"      \ })
"
"call deoplete#custom#source('tabnine', 'rank', 300)
"call deoplete#custom#source('tabnine', 'min_pattern_length', 2)
"" call deoplete#custom#source('tabnine', 'is_volatile', v:false)
"call deoplete#custom#var('tabnine', {
"      \ 'line_limit': 300,
"      \ 'max_num_results': 5,
"      \ 'markers': ['.git/'],
"      \ })
"
"call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])
"
"call deoplete#custom#source('_', 'converters', [
"      \ 'converter_remove_overlap',
"      \ 'converter_case',
"      \ 'matcher_length',
"      \ 'converter_truncate_abbr',
"      \ 'converter_truncate_info',
"      \ 'converter_truncate_menu',
"      \ ])
"call deoplete#custom#source('tabnine', 'converters', [
"      \ 'converter_remove_overlap',
"      \ 'converter_truncate_info',
"      \ ])
"call deoplete#custom#source('eskk', 'converters', [])
"
"" call deoplete#custom#source('buffer', 'min_pattern_length', 9999)
"" call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
"" call deoplete#custom#source('clang', 'max_pattern_length', -1)
"
"call deoplete#custom#option('keyword_patterns', {
"      \ '_': '[a-zA-Z_]\k*\(?',
"      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
"      \ })
"
"" inoremap <silent><expr> <C-t> deoplete#manual_complete('file')
"
"call deoplete#custom#option({
"      \ 'auto_refresh_delay': 10,
"      \ 'camel_case': v:true,
"      \ 'skip_multibyte': v:true,
"      \ 'auto_preview': v:true,
"      \ })
"" call deoplete#custom#option('num_processes', 0)
"
"" call deoplete#custom#option('profile', v:true)
"" call deoplete#enable_logging('DEBUG', 'deoplete.log')
"" call deoplete#custom#source('clang', 'debug_enabled', 1)
"
"call deoplete#custom#option('candidate_marks',
"      \ ['A', 'S', 'D', 'F', 'G'])
""call deoplete#enable()
""
""" <TAB>: completion.
""inoremap <silent><expr> <TAB>
""      \ pumvisible() ? "\<C-n>" :
""      \ <SID>check_back_space() ? "\<TAB>" :
""      \ deoplete#manual_complete()
""function! s:check_back_space() abort
""  let col = col('.') - 1
""  return !col || getline('.')[col - 1]  =~ '\s'
""endfunction
""
""" <S-TAB>: completion back.
""inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
""
""inoremap <expr><C-g>       deoplete#refresh()
""inoremap <expr><C-e>       deoplete#cancel_popup()
""inoremap <silent><expr><C-l>       deoplete#complete_common_string()
""
""" <CR>: close popup and save indent.
""inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
""function! s:my_cr_function() abort
""  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
""endfunction
"" }}}

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

" test.vim {{{
let test#strategy = "tslime"
let g:test#preserve_screen = 1
map <Leader>rt :TestFile<CR>
map <Leader>rs :TestNearest<CR>
map <Leader>rl :TestLast<CR>
map <Leader>ra :TestSuite<CR>
" }}}

" tslime.vim {{{
let g:tslime_always_current_session = 1
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

" Gundo {{{
nnoremap <Leader>ud :GundoToggle<CR>
" }}}

" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='¦'
" }}}

" vim-go {{{
let g:go_fmt_command = "goimports"
" }}}
