local nnoremap = require("const.keymap").nnoremap
local nvim_tree = require("nvim-tree")
nnoremap("<leader>nt", nvim_tree.toggle)
