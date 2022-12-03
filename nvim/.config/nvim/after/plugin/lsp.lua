local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nnoremap = require('const.keymap').nnoremap

local on_attach = function()
    nnoremap("K", vim.lsp.buf.hover, {buffer=0})
    nnoremap("gd", vim.lsp.buf.definition, {buffer=0})
    nnoremap("gt", vim.lsp.buf.type_definition, {buffer=0})
    nnoremap("gi", vim.lsp.buf.implementation, {buffer=0})
    nnoremap("<leader>lf", vim.lsp.buf.format, {buffer=0})
    nnoremap("<leader>rn", vim.lsp.buf.rename, {buffer=0})
    nnoremap("<leader>rr", vim.lsp.buf.references, {buffer=0})
    nnoremap("<leader>ca", vim.lsp.buf.code_action, {buffer=0})
    nnoremap("<leader>dj", vim.diagnostic.goto_next, {buffer=0})
    nnoremap("<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    nnoremap("<leader>dK", vim.diagnostic.open_float, {buffer=0})
    nnoremap("<leader>fe", "<CMD>Telescope diagnostics<CR>")
    nnoremap("<leader>fi", "<CMD>Telescope lsp_implementations<CR>")
    nnoremap("<leader>fd", "<CMD>Telescope lsp_definitions<CR>")
    nnoremap("<leader>fr", "<CMD>Telescope lsp_references<CR>")
    nnoremap("<leader>ft", "<CMD>Telescope lsp_type_definitions<CR>")
end

-- python lsp server
require('lspconfig').pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            -- Settings: https://github.com/microsoft/pyright/blob/main/docs/settings.md#pyright-settings
            analysis = {
                typeCheckingMode = "basic",
                -- Configuration: https://github.com/microsoft/pyright/blob/main/docs/configuration.md#diagnostic-rule-defaults
                diagnosticSeverityOverrides = {}
            }
        }
    }
}
-- typescrtip/ javascript lsp server
require('lspconfig').tsserver.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
-- docker lsp server
require('lspconfig').dockerls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
-- go lsp server
require('lspconfig').gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
-- lua lsp server
require('lspconfig').sumneko_lua.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
-- rust lsp server
require('lspconfig').rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
-- c lsp server
require('lspconfig').clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach
}
-- tailwind lsp server
require('lspconfig').tailwindcss.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
