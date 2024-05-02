local nnoremap = require("const.keymap").nnoremap
local vnoremap = require("const.keymap").vnoremap
local ipython = require("ipython-tmux")

nnoremap("<leader>ic", ipython.connect, { silent = true })
nnoremap("<leader>id", ipython.disconnect, { silent = true })
nnoremap("<leader>is", ipython.send_cell, { silent = true })
nnoremap("<leader>in", ipython.save_ipynb, { silent = true })
nnoremap("<leader>ie", ipython.save_state, { silent = true })
-- nnoremap("<leader>ib", ipython.send_before, { silent = true })
-- nnoremap("<leader>ia", ipython.send_all, { silent = true })
-- vnoremap("<leader>is", ipython.send_visual, { silent = true })
