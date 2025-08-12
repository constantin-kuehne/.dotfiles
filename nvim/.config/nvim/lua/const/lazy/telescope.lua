return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "AckslD/nvim-neoclip.lua",
        "rcarriga/nvim-notify",
        "echasnovski/mini.icons",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local telescope = require("telescope")
        local notify = require("notify")

        notify.setup({
            render = "compact",
        })

        telescope.setup({
            defaults = require('telescope.themes').get_ivy({
                file_ignore_patterns = { ".git/", "venv", "__pycache__", "wandb" }
            }),
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        })

        telescope.load_extension("fzf")
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

        local log = require("plenary.log").new({
            plugin = "notify",
            level = "debug",
            use_console = false
        })

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.notify = function(msg, level, opts)
            log.info(msg, level, opts)
            if string.find(msg, "method .* is not supported") then
                return
            end

            notify(msg, level, opts)
        end

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
                no_ignore_parent = true,
            })
        end, { desc = "[Telescope] Find files" })

        vim.keymap.set("n", "<leader>fo", builtin.live_grep, { desc = "[Telescope] Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[Telescope] Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[Telescope] Help tags" })
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[Telescope] Git files" })
        vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "[Telescope] Jumplist" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[Telescope] Keymaps" })
        vim.keymap.set("n", "<leader>fq", function()
            vim.cmd("ccl")
            builtin.quickfix()
        end, { desc = "[Telescope] Quickfix" })
        vim.keymap.set("n", "<leader>fc", "<cmd>Telescope neoclip<cr>", { desc = "[Telescope] Clipboard" })
        vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "[Telescope] Spell suggestions" })

        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local make_entry = require("telescope.make_entry")
        local conf = require("telescope.config").values

        local live_multigrep = function(opts)
            opts = opts or {}
            opts.cwd = opts.cwd or vim.uv.cwd()

            local finder = finders.new_async_job {
                command_generator = function(prompt)
                    if not prompt or prompt == "" then
                        return nil
                    end

                    local pieces = vim.split(prompt, "  ")
                    local args = { "rg" }
                    if pieces[1] then
                        table.insert(args, "-e")
                        table.insert(args, pieces[1])
                    end

                    if pieces[2] then
                        table.insert(args, "-g")
                        table.insert(args, pieces[2])
                    end

                    ---@diagnostic disable-next-line: deprecated
                    return vim.tbl_flatten {
                        args,
                        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
                    }
                end,
                entry_maker = make_entry.gen_from_vimgrep(opts),
                cwd = opts.cwd,
            }

            pickers.new(opts, {
                debounce = 100,
                prompt_title = "Multi Grep",
                finder = finder,
                previewer = conf.grep_previewer(opts),
                sorter = require("telescope.sorters").empty(),
            }):find()
        end

        vim.keymap.set("n", "<leader>fl", live_multigrep, { desc = "[Telescope] Live multi grep" })
    end
}
