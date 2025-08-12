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

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "<leader>ll", quickfix_toggle, {
    silent = true,
    desc = "Toggle Quickfix/Loclist"
})

vim.keymap.set("x", "<leader>p", [["_dp]], { desc = "Paste without replacing register" })
vim.keymap.set("x", "<leader>P", [["_dP]], { desc = "Paste before cursor without replacing register" })
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "Paste from system clipboard before cursor" })

vim.keymap.set("n", "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard (line)" })

vim.keymap.set("n", "<leader>d", [["_d]], { desc = "Delete without replacing register" })
vim.keymap.set("v", "<leader>d", [["_d]], { desc = "Delete without replacing register" })

vim.keymap.set("n", "<leader>rq", "<cmd>'<,'>normal @<cr>", { desc = "Run macro in visual selection" })
vim.keymap.set("v", "<leader>rq", "<cmd>normal @<cr>", { desc = "Run macro in visual selection" })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix" })
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
