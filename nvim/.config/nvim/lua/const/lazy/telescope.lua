return {
    "nvim-telescope/telescope.nvim",
    dependencies = {"AckslD/nvim-neoclip.lua", "rcarriga/nvim-notify"},
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                file_ignore_patterns = {".git/"}
            }
        })

        telescope.load_extension("neoclip")
        telescope.load_extension("notify")

        require('neoclip').setup({
            keys = {
                telescope = {
                    i = {
                        select = '<cr>',
                        paste = '<c-k>',
                        paste_behind = '<c-K>',
                        custom = {}
                    }
                }
            }
        })

        local log = require("plenary.log").new {
            plugin = "notify",
            level = "debug",
            use_console = false
        }

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.notify = function(msg, level, opts)
            log.info(msg, level, opts)
            if string.find(msg, "method .* is not supported") then
                return
            end

            require "notify"(msg, level, opts)
        end

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files({
                hidden = true
            })
        end)
        vim.keymap.set("n", "<leader>fl", builtin.live_grep)
        vim.keymap.set("n", "<leader>fb", builtin.buffers)
        vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        vim.keymap.set("n", "<leader>fg", builtin.git_files)
        vim.keymap.set("n", "<leader>fc", "<cmd>Telescope neoclip<cr>")

    end
}
