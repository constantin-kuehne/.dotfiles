local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup{
    capabilities = capabilities,
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
require('lspconfig').tsserver.setup{capabilities = capabilities}
require('lspconfig').dockerls.setup{capabilities = capabilities}
require('lspconfig').gopls.setup{capabilities = capabilities}
require('lspconfig').sumneko_lua.setup{
    capabilities = capabilities,
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
require('lspconfig').rust_analyzer.setup{capabilities = capabilities}
require('lspconfig').clangd.setup{capabilities = capabilities}
require('lspconfig').tailwindcss.setup{capabilities = capabilities}

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
