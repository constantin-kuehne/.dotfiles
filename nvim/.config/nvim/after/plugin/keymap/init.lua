local Remap = require("const.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("<leader>l", "<cmd>lcl<cr><cmd>ccl<cr>", {silent = true})

xnoremap("<leader>p", "\"_dp")
xnoremap("<leader>P", "\"+P")
nnoremap("<leader>p", "\"+p")
nnoremap("<leader>P", "\"+P")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

-- nnoremap("<leader>f", function()
--     vim.lsp.buf.format()
-- end)

nnoremap("<leader>rq", "<cmd>'<,'>normal @<cr>")

vnoremap("<leader>rq", "<cmd>normal @<cr>")

