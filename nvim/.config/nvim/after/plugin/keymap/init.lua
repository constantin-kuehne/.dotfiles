local Remap = require("const.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

local function quickfix_toggle()
    for _, value in pairs(vim.api.nvim_list_wins()) do
        local win_type = vim.fn.win_gettype(value)
        if win_type == "quickfix" then
            vim.cmd("ccl")
            return
        end
        if win_type == "loclist" then
            vim.cmd("lcl")
            return
        end
    end
    vim.cmd("copen")
end

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("<leader>l", quickfix_toggle, { silent = true })

xnoremap("<leader>p", "\"_dp")
xnoremap("<leader>P", "\"_dP")
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

nnoremap("<C-j>", "<cmd>cnext<CR>zz")
nnoremap("<C-k>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")
