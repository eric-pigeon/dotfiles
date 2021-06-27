" vim: foldmethod=marker

let s:is_win = has('win32') || has('win64')

function! s:extend_opts(dict, eopts, prepend) " {{{
  if empty(a:eopts)
    return
  endif
  if has_key(a:dict, 'options')
    if type(a:dict.options) == s:TYPE.list && type(a:eopts) == s:TYPE.list
      if a:prepend
        let a:dict.options = extend(copy(a:eopts), a:dict.options)
      else
        call extend(a:dict.options, a:eopts)
      endif
    else
      let all_opts = a:prepend ? [a:eopts, a:dict.options] : [a:dict.options, a:eopts]
      let a:dict.options = join(map(all_opts, 'type(v:val) == s:TYPE.list ? join(map(copy(v:val), "fzf#shellescape(v:val)")) : v:val'))
    endif
  else
    let a:dict.options = a:eopts
  endif
endfunction " }}}

function! s:merge_opts(dict, eopts) " {{{
  return s:extend_opts(a:dict, a:eopts, 0)
endfunction " }}}

function! s:warn(message) " {{{
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction " }}}

function! fzf#vim#files(dir, ...) " {{{
  let args = {}
  if !empty(a:dir)
    if !isdirectory(expand(a:dir))
      return s:warn('Invalid directory')
    endif
    let slash = (s:is_win && !&shellslash) ? '\\' : '/'
    let dir = substitute(a:dir, '[/\\]*$', slash, '')
    let args.dir = dir
  else
    let dir = s:shortpath()
  endif

  let args.options = ['-m', '--prompt', strwidth(dir) < &columns / 2 - 20 ? dir : '> ']
  call s:merge_opts(args, get(g:, 'fzf_files_options', []))
  return s:fzf('files', args, a:000)
endfunction " }}}

function! s:fzf(name, opts, extra) " {{{
  let [extra, bang] = [{}, 0]
  if len(a:extra) <= 1
    let first = get(a:extra, 0, 0)
    if type(first) == s:TYPE.dict
      let extra = first
    else
      let bang = first
    endif
  elseif len(a:extra) == 2
    let [extra, bang] = a:extra
  else
    throw 'invalid number of arguments'
  endif

  let eopts  = has_key(extra, 'options') ? remove(extra, 'options') : ''
  let merged = extend(copy(a:opts), extra)
  call s:merge_opts(merged, eopts)
  return fzf#run(s:wrap(a:name, merged, bang))
endfunction " }}}
