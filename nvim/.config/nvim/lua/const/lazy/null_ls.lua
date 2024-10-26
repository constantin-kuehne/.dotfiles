return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require('null-ls')

        local on_attach = function()
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
                buffer = 0
            })
        end

        null_ls.setup({
            sources = {null_ls.builtins.formatting.black, null_ls.builtins.formatting.isort,
                       null_ls.builtins.formatting.prettierd, null_ls.builtins.formatting.ocamlformat -- null_ls.builtins.formatting.latexindent
            },
            on_attach = on_attach
        })

    end
}
