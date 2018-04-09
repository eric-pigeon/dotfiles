fu! zvim#util#source_rc(file) abort
    if filereadable(g:Config_Main_Home. '/' . a:file)
        execute 'source ' . g:Config_Main_Home  . '/' . a:file
    endif
endf

fu! zvim#util#Generate_ignore(ignore,tool, ...) abort
    let ignore = []
    if a:tool ==# 'ag'
        for ig in split(a:ignore,',')
            call add(ignore, '--ignore')
            call add(ignore, ig )
        endfor
    elseif a:tool ==# 'rg'
        for ig in split(a:ignore,',')
            call add(ignore, '-g')
            if a:0 > 0
                call add(ignore, "'!" . ig . "'")
            else
                call add(ignore, '!' . ig)
            endif
        endfor
    endif
    return ignore
endf
