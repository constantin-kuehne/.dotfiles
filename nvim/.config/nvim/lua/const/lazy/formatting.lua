local python_formatter = {
    "ruff",
}

return {
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason-org/mason.nvim", "nvimtools/none-ls.nvim", "ThePrimeagen/refactoring.nvim" },
        config = function()
            local null_ls = require("null-ls")

            local formatter = { "prettierd" }
            vim.list_extend(formatter, python_formatter)

            require("mason-null-ls").setup({
                ensure_installed = formatter,
                automatic_installation = false,
                handlers = {
                    ["black"] = function()
                        null_ls.register(null_ls.builtins.formatting.black.with({
                            extra_args = { "--fast" }
                        }))
                    end,
                    ["clang_format"] = function()
                        null_ls.register(null_ls.builtins.formatting.clang_format.with({
                            extra_args = { "--style=file" }
                        }))
                    end,
                },
            })

            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.refactoring
                }
            })
        end,
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup {
                notify_on_error = false,
                formatters_by_ft = {
                    quarto = { 'injected' },
                    markdown = { 'injected' },
                    python = python_formatter,

                }
            }
        end,
    },
}
