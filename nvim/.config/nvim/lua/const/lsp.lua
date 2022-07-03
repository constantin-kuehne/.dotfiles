local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup{
    capabilities = capabilities,
    cmd = { "pyright-langserver", "--stdio" , "-p $NVIM_PATH/pyright.json"}
}
require('lspconfig').tsserver.setup{capabilities = capabilities}
require('lspconfig').dockerls.setup{capabilities = capabilities}
require('lspconfig').gopls.setup{capabilities = capabilities}
require('lspconfig').sumneko_lua.setup{capabilities = capabilities}
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
