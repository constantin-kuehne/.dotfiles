return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end)
        vim.keymap.set("n", "<leader>5", function()
            harpoon:list():select(5)
        end)
        vim.keymap.set("n", "<leader>,", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
    end
}
