function! neoformat#formatters#typescript#enabled() abort
    return ['prettierd']
endfunction

function! neoformat#formatters#typescript#prettierd() abort
    return {
        \ 'exe': 'prettierd',
        \ 'args': ['"%:p"'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction
