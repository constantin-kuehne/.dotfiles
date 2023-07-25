local nnoremap = require("const.keymap").nnoremap
local nvim_tree = require("nvim-tree.api")
nnoremap("<leader>nt", nvim_tree.tree.toggle)
