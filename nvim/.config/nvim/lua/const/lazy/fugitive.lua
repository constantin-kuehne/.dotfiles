return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git" })
        vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Git Commit" })

        local Const_Fugitive = vim.api.nvim_create_augroup("Const_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Const_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {
                    buffer = bufnr,
                    remap = false
                }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, vim.tbl_extend("error", opts, { desc = "Git Push" }))

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git('pull --rebase')
                end, vim.tbl_extend("error", opts, { desc = "Git Pull with Rebase" }))

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ",
                    vim.tbl_extend("error", opts, { desc = "Git Push with Tracking" }));
            end
        })

        vim.keymap.set("n", "gl", "<cmd>diffget //2<CR>", { desc = "Git Diff Get Local" })
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Git Diff Get Head" })
    end
}
