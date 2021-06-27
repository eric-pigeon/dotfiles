"function! YamlFolds()
"  if (v:lnum == 0)
"    return 0
"  endif
"
"  if indent(v:lnum) > indent(v:lnum - 1)
"    return ">"
"  endif
"  return (indent(v:lnum) / &shiftwidth) + 1
"endfunction
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
