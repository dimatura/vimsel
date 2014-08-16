" vimsel.vim
" Version: 0.0

if exists("g:loaded_vimsel") || &cp | finish | endif
let g:loaded_vimsel = 1
if !exists('g:sxiv_path')
    let g:sxiv_path = ''
endif

" main commands
command! -nargs=? -complete=dir Vimsel :call s:InlineVimSel(<f-args>)

" TODO more than one directory
" TODO maybe buf variables for directory
function! s:ExecSxiv(dirname)
    let l:cmd = g:sxiv_path . 'sxiv -rtoq ' . l:dirname 
    return system(cmd)
endfunction

function! s:InlineVimSel(...)
    if a:0 > 0
        let l:dirname = a:1
    else
        let l:dirname = './'
    end
    let l:output = ExecSxiv(l:dirname)
    " strip output
    let l:output = substitute(l:output, '[\r\n]*$', '', '')
    execute 'normal i' . l:output
endfunction
