return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            -- refer to `:h file-pattern` for more examples
            "BufReadPre /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/StudyObsidian/*.md",
            "BufNewFile /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/StudyObsidian/*.md",
            "BufReadPre /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/StudyObsidian/**/*.md",
            "BufNewFile /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/StudyObsidian/**/*.md",
            "BufReadPre /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/Notes/Notes/*.md",
            "BufNewFile /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/Notes/Notes/*.md",
            "BufReadPre /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/Notes/Notes/**/*.md",
            "BufNewFile /Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/Notes/Notes/**/*.md",
            "BufNewFile /Users/constantinkuehne/Library/Mobile Documents/iCloud~md~obsidian/Documents/**/*.md",
            "BufReadPre /Users/constantinkuehne/Library/Mobile Documents/iCloud~md~obsidian/Documents/**/*.md",
            "BufReadPre oil:///Users/constantinkuehne/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes/",
        },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            daily_notes = {
                folder = "dailies",
                date_format = "%Y-%m-%d",
                default_tags = { "daily-notes" },
                template = nil
            },
            workspaces = {
                {
                    name = "study",
                    path = "/Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/StudyObsidian",
                },
                {
                    name = "old_notes",
                    path = "/Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/Notes/Notes",
                },
                {
                    name = "notes",
                    path = "/Users/constantinkuehne/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes",
                },
            },

            -- see below for full list of options 👇
        },
        config = function(_, opts)
            require("obsidian").setup(opts)

            vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
            vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Open Daily Note" })
            vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Template" })
            vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianFollowLink<CR>", { desc = "Follow Link" })

            vim.keymap.set("n", "<leader>n", "<cmd>edit " .. vim.env.NOTES_PATH .. "/ToDos.md<CR>", { desc = "Open ToDos.md" })

            local function is_obsidian_vault()
                local path = vim.fn.getcwd()
                local stat = vim.loop.fs_stat(path .. "/.obsidian")
                return stat and stat.type == "directory"
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    if is_obsidian_vault() then
                        local plugin_name = "render-markdown"
                        require("lazy.core.loader").disable_rtp_plugin(plugin_name)
                        vim.notify("Unloaded " .. plugin_name .. " due to entering obsidian vault", vim.log.levels.WARN)

                        vim.opt_local.conceallevel = 1 -- or 3
                        vim.opt_local.tabstop = 2
                        vim.opt_local.shiftwidth = 2
                        vim.opt_local.softtabstop = 2
                        vim.opt_local.expandtab = true
                    end
                end,
            })
        end,
    },
    {
        "NFrid/due.nvim",
        config = function()
            local date_pattern = '(%d%d)%-(%d%d)'                    -- m, d
            local datetime_pattern = date_pattern .. ' (%d+):(%d%d)' -- m, d, h, min
            local fulldatetime_pattern = '(%d%d%d%d)%-' .. datetime_pattern
            require('due_nvim').setup({
                prescript = 'due: ',      -- prescript to due data
                prescript_hi = 'Comment', -- highlight group of it
                due_hi = 'String',        -- highlight group of the data itself
                ft = '*.md',              -- filename template to apply aucmds :)
                today = 'TODAY',          -- text for today's due
                today_hi = 'Character',   -- highlight group of today's due
                overdue = 'OVERDUE',      -- text for overdued
                overdue_hi = 'Error',     -- highlight group of overdued
                date_hi = 'Number',       -- highlight group of date string
                pattern_start = '@ ',     -- start for a date string pattern
                pattern_end = '|',        -- end for a date string pattern
                -- lua patterns: in brackets are 'groups of data', their order is described
                -- accordingly. More about lua patterns: https://www.lua.org/pil/20.2.html
                date_pattern = date_pattern,                                -- m, d
                datetime_pattern = datetime_pattern,
                datetime12_pattern = datetime_pattern .. ' (%a%a)',         -- m, d, h, min, am/pm
                fulldate_pattern = '(%d%d%d%d)%-' .. date_pattern,          -- y, m, d
                fulldatetime_pattern = fulldatetime_pattern,                -- y, m, d, h, min
                fulldatetime12_pattern = fulldatetime_pattern .. ' (%a%a)', -- y, m, d, h, min, am/pm
            })
        end
    },
    {
        'lfilho/note2cal.nvim',
        config = function()
            require("note2cal").setup({
                debug = false,                -- if true, prints a debug message an return early (won't schedule events)
                calendar_name = "Uni",        -- the name of the calendar as it appear on Calendar.app
                highlights = {
                    at_symbol = "WarningMsg", -- the highlight group for the "@" symbol
                    at_text = "Number",       -- the highlight group for the date-time part
                },
            })
        end,
        ft = "markdown",
    },
}
