return {
    "letieu/harpoon-lualine",
    dependencies = {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true
                }
            })

            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():add()
            end, { desc = "Add current file to Harpoon" })
            vim.keymap.set("n", "<leader>1", function()
                harpoon:list():select(1)
            end, { desc = "Select Harpoon 1" })
            vim.keymap.set("n", "<leader>2", function()
                harpoon:list():select(2)
            end, { desc = "Select Harpoon 2" })
            vim.keymap.set("n", "<leader>3", function()
                harpoon:list():select(3)
            end, { desc = "Select Harpoon 3" })
            vim.keymap.set("n", "<leader>4", function()
                harpoon:list():select(4)
            end, { desc = "Select Harpoon 4" })
            vim.keymap.set("n", "<leader>5", function()
                harpoon:list():select(5)
            end, { desc = "Select Harpoon 5" })
            vim.keymap.set("n", "<leader>,", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "Toggle Harpoon Quick Menu" })
        end
    }
}
