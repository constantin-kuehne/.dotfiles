return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "python", "lua" },
            auto_install = true,
            ignore_install = {},
            modules = {},
            sync_install = false,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            -- disable = { "json" },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- you can change this if you want.
                    goto_next_start = {
                        ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
                    },
                    goto_next_end = {
                        ["]B"] = { query = "@code_cell.outer", desc = "next code block" },
                    },
                    goto_previous_start = {
                        ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
                    },
                    goto_previous_end = {
                        ["[B"] = { query = "@code_cell.outer", desc = "previous code block" },
                    },
                },
                select = {
                    enable = true,
                    lookahead = true, -- you can change this if you want
                    keymaps = {
                        --- ... other keymaps
                        ["ib"] = { query = "@code_cell.inner", desc = "in block" },
                        ["ab"] = { query = "@code_cell.outer", desc = "around block" },
                    },
                },
                swap = { -- Swap only works with code blocks that are under the same
                    -- markdown header
                    enable = true,
                    swap_next = {
                        --- ... other keymap
                        ["<leader>sbl"] = "@code_cell.outer",
                    },
                    swap_previous = {
                        --- ... other keymap
                        ["<leader>sbh"] = "@code_cell.outer",
                    },
                },
            }
        })
        require("treesitter-context").setup({
            enable = true,
        })
    end

}
