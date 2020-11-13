function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction
function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction
function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction
setlocal foldmethod=expr
"setlocal foldexpr=YamlFolds()
setlocal foldexpr=GetPotionFold(v:lnum)

function! YamlKey(pigeon)
  let lineno = line('.')
  if lineno == 0
    " todo
    return ''
  endif
  let key = matchstr(getline('.'), '\s*\zs[^:]\+')
  let old_indent = indent(lineno)
  while 1
    let lineno = lineno -1

    if lineno == 0
      break
    endif

    let current_indent = indent(lineno)

    if current_indent < old_indent
      let old_indent = current_indent
      let key = matchstr(getline(lineno), '\s*\zs[^:]\+') . '.' . key
    endif

    if IndentLevel(lineno) == a:pigeon
      break
    end
  endwhile
  let @* = 't(''' . key . ''')'
endfunction

map <Leader>yk :call YamlKey(1)<cr>
