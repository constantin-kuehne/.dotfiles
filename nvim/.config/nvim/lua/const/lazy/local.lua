local local_plugins = {
    {
        "ipython-tmux",
        dir = "~/Documents/Coding/ipython-tmux.nvim",
        config = function()
            local ipython = require("ipython-tmux")
            ipython.setup()

            vim.keymap.set("n", "<leader>ic", ipython.connect, { silent = true, desc = "Connect to IPython" })
            vim.keymap.set("n", "<leader>id", ipython.disconnect, { silent = true, desc = "Disconnect from IPython" })
            vim.keymap.set("n", "<leader>is", ipython.send_cell, { silent = true, desc = "Send Cell to IPython" })
            vim.keymap.set("n", "<leader>in", ipython.save_ipynb, { silent = true, desc = "Save IPython as Notebook" })
            vim.keymap.set("n", "<leader>ie", ipython.save_state, { silent = true, desc = "Save IPython State" })
            vim.keymap.set("n", "<leader>ia", ipython.send_all, { silent = true, desc = "Send all cells to IPython" })
        end
    },
    -- {
    --     "notebook",
    --     dir = "~/Documents/Coding/notebook.nvim"
    -- }
    {
        "notes-list",
        dir = "~/Documents/Coding/notes-list.nvim",
        config = function()
            local notes_list = require("notes-list")

            notes_list.setup({
                notes_dir = vim.fn.expand(
                    "/Users/constantinkuehne/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
                ),
            })

            vim.keymap.set("n", "<leader>td", function()
                notes_list.search()
            end, { desc = "Open Notes List" })
        end
    }
}

return local_plugins
