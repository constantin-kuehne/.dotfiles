nnoremap <leader>dct <cmd>lua require"dap".continue()<CR>
nnoremap <leader>dsv <cmd>lua require"dap".step_over()<CR>
nnoremap <leader>dsi <cmd>lua require"dap".step_into()<CR>
nnoremap <leader>dso <cmd>lua require"dap".step_out()<CR>
nnoremap <leader>dtb <cmd>lua require"dap".toggle_breakpoint()<CR>
nnoremap <leader>dsc <cmd>lua require"dap.ui.variables".scopes()<CR>
nnoremap <leader>dhh <cmd>lua require"dap.ui.variables".hover()<CR>
vnoremap <leader>dhv <cmd>lua require"dap.ui.variables".visual_hover()<CR>

nnoremap <leader>dui <cmd>lua require"dapui".toggle()<CR>

nnoremap <leader>duh <cmd>lua require"dap.ui.widgets".hover()<CR>
nnoremap <leader>duf <cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>

nnoremap <leader>dsbr <cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>
nnoremap <leader>dsbm <cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>
nnoremap <leader>dro <cmd>lua require"dap".repl.open()<CR>
nnoremap <leader>drl <cmd>lua require"dap".repl.run_last()<CR>


nnoremap <leader>dcc <cmd>lua require"telescope".extensions.dap.commands{}<CR>
nnoremap <leader>dco <cmd>lua require"telescope".extensions.dap.configurations{}<CR>
nnoremap <leader>dbl <cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>
nnoremap <leader>dv <cmd>lua require"telescope".extensions.dap.variables{}<CR>
nnoremap <leader>df <cmd>lua require"telescope".extensions.dap.frames{}<CR>
