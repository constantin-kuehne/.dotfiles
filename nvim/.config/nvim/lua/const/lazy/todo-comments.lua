return {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-telescope/telescope.nvim"},
    config = function()
        require("todo-comments").setup({})
        vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>")
        vim.keymap.set("n", "<leader>tl", "<cmd>TodoLocList<cr>")
    end
}
