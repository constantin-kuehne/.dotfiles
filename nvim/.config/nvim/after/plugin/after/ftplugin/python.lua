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

nnoremap("<leader>is", "<cmd>SlimeSend1 ipython --matplotlib<cr>")
nnoremap("<leader>ir", "<cmd>IPythonCellRun<CR>")

nnoremap("<leader>iR", "<cmd>IPythonCellRunTime<CR>")

nnoremap("<leader>ic", "<cmd>IPythonCellExecuteCell<CR>")

nnoremap("<leader>iC", "<cmd>IPythonCellExecuteCellJump<CR>")

nnoremap("<leader>il", "<cmd>IPythonCellClear<CR>")

nnoremap("<leader>ix", "<cmd>IPythonCellClose<CR>")

nnoremap("[c", "<cmd>IPythonCellPrevCell<CR>")
nnoremap("]c", "<cmd>IPythonCellNextCell<CR>")

nmap("<leader>ih", "<Plug>SlimeLineSend")
xmap("<leader>ih", "<Plug>SlimeRegionSend")

nnoremap("<leader>ip", "<cmd>IPythonCellPrevCommand<CR>")

nnoremap("<leader>iQ", "<cmd>IPythonCellRestart<CR>")

nnoremap("<leader>id", "<cmd>SlimeSend1 %debug<CR>")

nnoremap("<leader>iq", "<cmd>SlimeSend1 exit<CR>")

nmap("<F9>", "<cmd>IPythonCellInsertAbove<CR>a")
nmap("<F10>", "<cmd>PythonCellInsertBelow<CR>a")

imap("<F9>", "<C-o><cmd>PythonCellInsertAbove<CR>")
imap("<F10>", "<C-o><cmd>PythonCellInsertBelow<CR>")
