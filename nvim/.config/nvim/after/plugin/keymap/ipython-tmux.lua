local nnoremap = require("const.keymap").nnoremap
local vnoremap = require("const.keymap").vnoremap
local ipython = require("ipython-tmux")

nnoremap("<leader>ic", ipython.connect, { silent = true })
nnoremap("<leader>id", ipython.disconnect, { silent = true })
nnoremap("<leader>is", ipython.send_cell, { silent = true })
-- vnoremap("<leader>is", ipython.send_visual, { silent = true })
