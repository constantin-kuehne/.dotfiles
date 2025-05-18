return {
    {
        "stevearc/dressing.nvim",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    {
        -- "zbirenbaum/copilot-cmp",
        "zbirenbaum/copilot.lua",
        lazy = false,
        -- dependencies = { { "zbirenbaum/copilot.lua", lazy = false } },
        enabled = true,
        config = function()
            require("copilot").setup({
                suggestion = { enabled = true, auto_trigger = true },
                panel = { enabled = true, auto_refresh = true, layout = { position = "right", ratio = 0.3 } },
                server_opts_overrides = {
                    settings = {
                        telemetry = {
                            telemetryLevel = "off",
                        },
                    },
                },
            })
            -- require("copilot_cmp").setup()
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        enabled = true,
        version = false, -- set this if you want to always pull the latest change
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "echasnovski/mini.icons",
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                enabled = false,
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                enabled = function()
                    local function is_obsidian_vault()
                        local path = vim.fn.getcwd()
                        local stat = vim.loop.fs_stat(path .. "/.obsidian")
                        return stat and stat.type == "directory"
                    end

                    return not is_obsidian_vault()
                end,

                opts = {
                    file_types = { "markdown", "Avante" },
                    code = {
                        style = "full",
                        border = "thin"
                    }
                },
                ft = { "markdown", "Avante" },
            },
        },
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            provider = "copilot",
            behaviour = {
                auto_suggestions = false
            },
            windows = {
                ask = {
                    start_insert = false,
                }
            },
            copilot = {
                endpoint = "https://api.githubcopilot.com",
                proxy = nil,            -- [protocol://]host[:port] Use this proxy
                allow_insecure = false, -- Allow insecure server connections
                timeout = 30000,        -- Timeout in milliseconds
                temperature = 0,
                max_tokens = 1000000,
            },
        }
    },
}
