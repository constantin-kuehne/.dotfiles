function! neoformat#formatters#javascriptreact#enabled() abort
    return ['prettierd']
endfunction

function! neoformat#formatters#javascriptreact#prettierd() abort
    return {
        \ 'exe': 'prettierd',
        \ 'args': ['"%:p"'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction
