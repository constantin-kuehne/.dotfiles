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
                        ["]b"] = { query = "@code_cell.inner", desc = "next code block start" },
                        ["]c"] = { query = "@class.outer", desc = "next code class start" },
                        ["]f"] = { query = "@function.outer", desc = "next code function start" },
                    },
                    goto_next_end = {
                        ["]B"] = { query = "@code_cell.outer", desc = "next code block end" },
                        ["]C"] = { query = "@class.outer", desc = "next code class end" },
                        ["]F"] = { query = "@function.outer", desc = "next code function end" },
                    },
                    goto_previous_start = {
                        ["[b"] = { query = "@code_cell.inner", desc = "previous code block start" },
                        ["[c"] = { query = "@class.outer", desc = "previous code class start" },
                        ["[f"] = { query = "@function.outer", desc = "previous code function start" },
                    },
                    goto_previous_end = {
                        ["[B"] = { query = "@code_cell.outer", desc = "previous code block end" },
                        ["[C"] = { query = "@class.outer", desc = "previous code class end" },
                        ["[F"] = { query = "@function.outer", desc = "previous code function end" },
                    },
                },
                select = {
                    enable = true,
                    lookahead = true, -- you can change this if you want
                    keymaps = {
                        --- ... other keymaps
                        ["ib"] = { query = "@code_cell.inner", desc = "in block" },
                        ["ab"] = { query = "@code_cell.outer", desc = "around block" },
                        ["af"] = { query = "@function.outer", desc = "around function" },
                        ["if"] = { query = "@function.inner", desc = "inner function" },
                        ["ac"] = { query = "@class.outer", desc = "outer class" },
                        ["ic"] = { query = "@class.inner", desc = "inner class" },
                        ["al"] = { query = "@loop.outer", desc = "outer loop" },
                        ["il"] = { query = "@loop.inner", desc = "inner loop" },
                        ["as"] = { query = "@statement.outer", desc = "outer statement" },
                        ["ad"] = { query = "@conditional.outer", desc = "outer conditional" },
                        ["id"] = { query = "@conditional.inner", desc = "inner conditional" },
                        ["a#"] = { query = "@comment.outer", desc = "outer comment" },
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
