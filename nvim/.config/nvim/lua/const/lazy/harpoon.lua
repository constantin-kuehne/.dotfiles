return {
    "ThePrimeagen/harpoon",
    config = function()
        local harpoon_mark = require("harpoon.mark")
        local harpoon_ui = require("harpoon.ui")

        vim.keymap.set("n", "<C-h>", harpoon_mark.add_file, {
            silent = true
        })
        vim.keymap.set("n", "<leader>1", function()
            harpoon_ui.nav_file(1)
        end, {
            silent = true
        })
        vim.keymap.set("n", "<leader>2", function()
            harpoon_ui.nav_file(2)
        end, {
            silent = true
        })
        vim.keymap.set("n", "<leader>3", function()
            harpoon_ui.nav_file(3)
        end, {
            silent = true
        })
        vim.keymap.set("n", "<leader>4", function()
            harpoon_ui.nav_file(4)
        end, {
            silent = true
        })
        vim.keymap.set("n", "<leader>,", harpoon_ui.toggle_quick_menu, {
            silent = true
        })
    end
}
