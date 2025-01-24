local local_plugins = {
    {
        "ipython-tmux",
        dir = "~/Documents/Coding/ipython-tmux.nvim",
        config = function()
            local ipython = require("ipython-tmux")
            ipython.setup()

            vim.keymap.set("n", "<leader>ic", ipython.connect, { silent = true })
            vim.keymap.set("n", "<leader>id", ipython.disconnect, { silent = true })
            vim.keymap.set("n", "<leader>is", ipython.send_cell, { silent = true })
            vim.keymap.set("n", "<leader>in", ipython.save_ipynb, { silent = true })
            vim.keymap.set("n", "<leader>ie", ipython.save_state, { silent = true })
        end
    },
    -- {
    --     "notebook",
    --     dir = "~/Documents/Coding/notebook.nvim"
    -- }
}

return local_plugins
