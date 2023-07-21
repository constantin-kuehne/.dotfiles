local nnoremap = require('const.keymap').nnoremap
local null_ls = require('null-ls')

local on_attach = function()
    nnoremap("<leader>lf", vim.lsp.buf.format, { buffer = 0 })
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.prettier.with({
            extra_args = { "--tab-width", "4" }
        })
    },
    on_attach = on_attach,
})
