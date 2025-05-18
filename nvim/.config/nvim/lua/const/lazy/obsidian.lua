return {
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
                name = "notes",
                path = "/Users/constantinkuehne/Library/CloudStorage/OneDrive-Personal/Notes/Notes",
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

        local function is_obsidian_vault()
            local path = vim.fn.getcwd()
            local stat = vim.loop.fs_stat(path .. "/.obsidian")
            return stat and stat.type == "directory"
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                if is_obsidian_vault() then
                    vim.opt_local.conceallevel = 2 -- or 3
                end
            end,
        })
    end,
}
