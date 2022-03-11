function! neoformat#formatters#typescriptreact#enabled() abort
    return ['prettierd']
endfunction

function! neoformat#formatters#typescriptreact#prettierd() abort
    return {
        \ 'exe': 'prettierd',
        \ 'args': ['"%:p"'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction
