return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        -- enabled = function()
        --     local function is_obsidian_vault()
        --         local path = vim.fn.getcwd()
        --         local stat = vim.loop.fs_stat(path .. "/.obsidian")
        --         return stat and stat.type == "directory"
        --     end

        --     return not is_obsidian_vault()
        -- end,
        cond = function()
            return not vim.g.remote_neovim_host
        end,
        opts = {
            file_types = { "markdown", "Avante", "codecompanion" },
            code = {
                style = "full",
                border = "thin"
            },
            bullet = {
                enabled = false
            },
            checkbox = {
                enabled = true
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
        "folke/sidekick.nvim",
        cmd = "Sidekick",
        cond = function()
            return not vim.g.remote_neovim_host
        end,
        opts = {
            -- add any options here
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true,
                    create = "split",
                    split = {
                        vertical = true, -- vertical or horizontal split
                        size = 0.4,      -- size of the split (0-1 for percentage)
                    },
                },
            },
            nes = {
                enabled = true,
            }
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },
    },
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            adapters = {
                http = {
                    gemini = function()
                        return require("codecompanion.adapters").extend("gemini", {
                            env = {
                                api_key = "cmd:pass show gemini-api"
                            }
                        })
                    end
                }
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
        cond = function()
            return not vim.g.remote_neovim_host
        end,
        lazy = false,
        -- dependencies = { { "zbirenbaum/copilot.lua", lazy = false } },
        dependencies = {
            {
                "copilotlsp-nvim/copilot-lsp",
                init = function()
                    vim.g.copilot_nes_debounce = 10
                end
            }
        },
        enabled = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    keymap = {
                        accept = "<C-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<C-j>",
                        prev = "<C-k>",
                        dismiss = "<C-d>",
                    }
                },
                panel = { enabled = true, auto_refresh = true, layout = { position = "right", ratio = 0.3 } },
                nes = {
                    enabled = false,
                    auto_trigger = true,
                    keymap = {
                        accept_and_goto = "<leader>n",
                        accept = false,
                        dismiss = "<ESC>",
                    },
                },
                server_opts_overrides = {
                    settings = {
                        telemetry = {
                            telemetryLevel = "off",
                        },
                    },
                },
            })

            vim.api.nvim_create_user_command("CopilotToggle", function()
                if vim.g.copilot_enabled == false then
                    vim.g.copilot_enabled = true
                    require("copilot.suggestion").toggle_auto_trigger()
                    vim.notify("Copilot Enabled", vim.log.levels.INFO)
                else
                    vim.g.copilot_enabled = false
                    require("copilot.suggestion").toggle_auto_trigger()
                    vim.notify("Copilot Disabled", vim.log.levels.WARN)
                end
            end, { desc = "Toggle GitHub Copilot" })

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
            --         local plugin_name = "copilot.lua"
            --         if is_online() and not require("lazy.core.config").plugins[plugin_name]._.loaded then
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
        cond = function()
            return not vim.g.remote_neovim_host
        end,
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
