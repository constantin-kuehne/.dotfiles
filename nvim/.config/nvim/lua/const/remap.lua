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

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>ll", quickfix_toggle, {
    silent = true
})

vim.keymap.set("x", "<leader>p", [["_dp]])
vim.keymap.set("x", "<leader>P", [["_dP]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>d", [["_d]])
vim.keymap.set("v", "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>rq", "<cmd>'<,'>normal @<cr>")
vim.keymap.set("v", "<leader>rq", "<cmd>normal @<cr>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
