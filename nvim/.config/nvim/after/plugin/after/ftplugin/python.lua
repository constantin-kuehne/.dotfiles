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
nnoremap("<leader>ir", ":IPythonCellRun<CR>")

nnoremap("<leader>iR", ":IPythonCellRunTime<CR>")

nnoremap("<leader>ic", ":IPythonCellExecuteCell<CR>")

nnoremap("<leader>iC", ":IPythonCellExecuteCellJump<CR>")

nnoremap("<leader>il", ":IPythonCellClear<CR>")

nnoremap("<leader>ix", ":IPythonCellClose<CR>")

nnoremap("[c", ":IPythonCellPrevCell<CR>")
nnoremap("]c", ":IPythonCellNextCell<CR>")

nmap("<leader>ih", "<Plug>SlimeLineSend")
xmap("<leader>ih", "<Plug>SlimeRegionSend")

nnoremap("<leader>ip", ":IPythonCellPrevCommand<CR>")

nnoremap("<leader>iQ", ":IPythonCellRestart<CR>")

nnoremap("<leader>id", ":SlimeSend1 %debug<CR>")

nnoremap("<leader>iq", ":SlimeSend1 exit<CR>")

nmap("<F9>", ":IPythonCellInsertAbove<CR>a")
nmap("<F10>", ":IPythonCellInsertBelow<CR>a")

imap("<F9>", "<C-o>:IPythonCellInsertAbove<CR>")
imap("<F10>", "<C-o>:IPythonCellInsertBelow<CR>")
