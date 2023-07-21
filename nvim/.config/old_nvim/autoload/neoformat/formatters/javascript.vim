function! neoformat#formatters#javascript#enabled() abort
    return ['prettierd']
endfunction

function! neoformat#formatters#javascript#prettierd() abort
    return {
        \ 'exe': 'prettierd',
        \ 'args': ['"%:p"'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction
