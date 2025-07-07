return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = function()
            local function is_obsidian_vault()
                local path = vim.fn.getcwd()
                local stat = vim.loop.fs_stat(path .. "/.obsidian")
                return stat and stat.type == "directory"
            end

            return not is_obsidian_vault()
        end,
        opts = {
            file_types = { "markdown", "Avante", "codecompanion" },
            code = {
                style = "full",
                border = "thin"
            },
            ignore = function(bufnr)
                local function is_buf_in_floating_win(bufnr)
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        if vim.api.nvim_win_get_buf(win) == bufnr then
                            local config = vim.api.nvim_win_get_config(win)
                            local is_correct_ft = vim.bo[bufnr].filetype == "markdown"
                            if config.relative == "win" and is_correct_ft then
                                return true
                            end
                        end
                    end
                    return false
                end
                return is_buf_in_floating_win(bufnr)
            end

        },
        ft = { "markdown", "Avante", "codecompanion" },
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "MeanderingProgrammer/render-markdown.nvim",
        },
        opts = {
            adapters = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        env = {
                            api_key = "cmd:pass show gemini-api"
                        }
                    })
                end
            },
            strategies = {
                chat = {
                    adapter = "gemini",
                },
                inline = {
                    adapter = "gemini",
                    keymaps = {
                        accept_change = {
                            modes = { n = "ga" },
                            description = "Accept the suggested change",
                        },
                        reject_change = {
                            modes = { n = "gr" },
                            description = "Reject the suggested change",
                        },
                    },
                },
            },
            display = {
                chat = {
                    window = {
                        position = "right",
                        width = 0.35,
                    },
                },
            },
        },
        config = function(_, opts)
            require("codecompanion").setup(opts)
            vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat<cr>",
                { noremap = true, silent = true, desc = "Open CodeCompanion" })
            vim.keymap.set("n", "<leader>ae", "<cmd>CodeCompanion<cr>",
                { noremap = true, silent = true, desc = "Open CodeCompanion Inline" })
            vim.keymap.set("v", "<leader>ae", ":'<,'>CodeCompanion<cr>",
                { noremap = true, silent = true, desc = "Open CodeCompanion Inline" })
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

            -- local function is_online()
            --     local handle = io.popen("ping -c 1 api.github.com >/dev/null 2>&1 && echo 1 || echo 0")
            --     if not handle then
            --         return false
            --     end
            --     local result = handle:read("*a")
            --     handle:close()
            --     return tonumber(result) == 1
            -- end

            -- vim.api.nvim_create_autocmd("FocusLost", {
            --     callback = function()
            --         if not is_online() then
            --             local plugin_name = "copilot.lua"
            --             require("lazy.core.loader").disable_rtp_plugin(plugin_name)
            --             vim.notify("Unloaded " .. plugin_name .. " due to no internet", vim.log.levels.WARN)
            --         end
            --     end
            -- })

            -- vim.api.nvim_create_autocmd("FocusGained", {
            --     callback = function()
            --         local plugin_name = "github/copilot.vim"
            --         if is_online() and not require("lazy.core.loader").load[plugin_name].loaded then
            --             vim.cmd("Lazy load " .. plugin_name)
            --             vim.notify("Reloaded " .. plugin_name .. " after regaining internet", vim.log.levels.INFO)
            --         end
            --     end
            -- })
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        enabled = false,
        version = false, -- set this if you want to always pull the latest change
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "echasnovski/mini.icons",
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            "folke/snacks.nvim",
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
        },
        ---@module "avante"
        ---@type avante.Config
        opts = {
            input = {
                provider = "snacks",
            },
            selector = {
                provider = "snacks",
            },
            provider = "copilot",
            behaviour = {
                auto_suggestions = false
            },
            windows = {
                ask = {
                    start_insert = false,
                }
            },
            providers = {
                copilot = {
                    endpoint = "https://api.githubcopilot.com",
                    proxy = nil,            -- [protocol://]host[:port] Use this proxy
                    allow_insecure = false, -- Allow insecure server connections
                    timeout = 30000,        -- Timeout in milliseconds
                    extra_request_body = {
                        temperature = 0,
                        max_tokens = 1000000,
                    }
                },
            }
        }
    },
}
