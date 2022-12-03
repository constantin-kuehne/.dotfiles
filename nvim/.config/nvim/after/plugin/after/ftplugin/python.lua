vim.g.slime_target = "tmux"
vim.g.slime_bracketed_paste = 1

if vim.env.TMUX then
    vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = ":.2"
    }
end

vim.g.slime_dont_ask_default = 0
vim.g.ipython_cell_send_ctrl_c = 0

local nnoremap = require("const.keymap").nnoremap
local nmap = require("const.keymap").nmap
local imap = require("const.keymap").imap
local xmap = require("const.keymap").xmap

nnoremap("<leader>s", "<cmd>SlimeSend1 ipython --matplotlib<cr>")
nnoremap("<Leader>r", ":IPythonCellRun<CR>")

nnoremap("<Leader>R", ":IPythonCellRunTime<CR>")

nnoremap("<Leader>c", ":IPythonCellExecuteCell<CR>")

nnoremap("<Leader>C", ":IPythonCellExecuteCellJump<CR>")

nnoremap("<Leader>l", ":IPythonCellClear<CR>")

nnoremap("<Leader>x", ":IPythonCellClose<CR>")

nnoremap("[c", ":IPythonCellPrevCell<CR>")
nnoremap("]c", ":IPythonCellNextCell<CR>")

nmap("<Leader>h", "<Plug>SlimeLineSend")
xmap("<Leader>h", "<Plug>SlimeRegionSend")

nnoremap("<Leader>p", ":IPythonCellPrevCommand<CR>")

nnoremap("<Leader>Q", ":IPythonCellRestart<CR>")

nnoremap("<Leader>d", ":SlimeSend1 %debug<CR>")

nnoremap("<Leader>q", ":SlimeSend1 exit<CR>")

nmap("<F9>", ":IPythonCellInsertAbove<CR>a")
nmap("<F10>", ":IPythonCellInsertBelow<CR>a")

imap("<F9>", "<C-o>:IPythonCellInsertAbove<CR>")
imap("<F10>", "<C-o>:IPythonCellInsertBelow<CR>")
