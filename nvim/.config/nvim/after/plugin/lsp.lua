require("neodev").setup({
    library = {
        enabled = true,  -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = false, -- runtime path
        types = true,    -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = false, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
    -- With lspconfig, Neodev will automatically setup your lua-language-server
    -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
    -- in your lsp start options
    lspconfig = true,
    -- much faster, but needs a recent built of lua-language-server
    -- needs lua-language-server >= 3.6.0
    pathStrict = true,
})
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nnoremap = require('const.keymap').nnoremap
local vnoremap = require('const.keymap').vnoremap
local telescope_builtin = require('telescope.builtin')

local on_attach = function()
    nnoremap("K", vim.lsp.buf.hover, { buffer = 0 })
    nnoremap("gd", vim.lsp.buf.definition, { buffer = 0 })
    nnoremap("gt", vim.lsp.buf.type_definition, { buffer = 0 })
    nnoremap("gi", vim.lsp.buf.implementation, { buffer = 0 })
    nnoremap("<leader>lf", vim.lsp.buf.format, { buffer = 0 })
    nnoremap("<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
    nnoremap("<leader>rr", vim.lsp.buf.references, { buffer = 0 })
    nnoremap("<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
    vnoremap("<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
    nnoremap("<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
    nnoremap("<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
    nnoremap("<leader>dK", vim.diagnostic.open_float, { buffer = 0 })
    nnoremap("<leader>fe", telescope_builtin.diagnostics)
    nnoremap("<leader>fi", telescope_builtin.lsp_implementations)
    nnoremap("<leader>fd", telescope_builtin.lsp_definitions)
    nnoremap("<leader>fr", telescope_builtin.lsp_references)
    nnoremap("<leader>ft", telescope_builtin.lsp_type_definitions)
end

-- python lsp server
require('lspconfig').pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            -- Settings: https://github.com/microsoft/pyright/blob/main/docs/settings.md#pyright-settings
            analysis = {
                typeCheckingMode = "off",
                pythonVersion = "3.9",
                -- Configuration: https://github.com/microsoft/pyright/blob/main/docs/configuration.md#diagnostic-rule-defaults
                diagnosticSeverityOverrides = {
                    reportUnusedExpression = "none"

                }
            }
        }
    }
})

-- typescrtip/ javascript lsp server
require('lspconfig').tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

-- docker lsp server
require('lspconfig').dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

-- go lsp server
require('lspconfig').gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

-- lua lsp server
require('lspconfig').lua_ls.setup({
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
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

-- rust lsp server
require('lspconfig').rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

-- c lsp server
require('lspconfig').clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

-- ocaml lsp server
require('lspconfig').ocamllsp.setup({
    capabilities = capabilities,
    on_attach = on_attach
})

-- grammar lsp server
require('lspconfig').ltex.setup({
    capabilities = capabilities,
    on_attach = function()
        on_attach()
        require('ltex_extra').setup({
            load_langs = { 'en-GB', 'de-DE' },
            init_check = true,
            path = vim.fn.expand("~") .. "/.local/share/ltex"
        })
    end,
    settings = {
        ltex = {
            language = "en-GB"
        }
    },
    autostart = false
})

-- latex lsp server
require('lspconfig').texlab.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        texlab = {
            bibtexFormatter = "texlab",
            build = {
                -- args = { "-pdflua", "-pvc", "-bibtex", "-auxdir=./AUX", "-interaction=nonstopmode", "-synctex=1", "%f" },
                args = { "-pdflua", "-pvc", "-bibtex", "-auxdir=./AUX", "-interaction=nonstopmode", "%f" },
                executable = "latexmk",
                auxDirectory = "./AUX",
                logDirectory = "./AUX",
                forwardSearchAfter = false,
                onSave = false
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 200,
            formatterLineLength = 80,
            forwardSearch = {
                args = {}
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            }
        }
    }

})
require('lspconfig').r_language_server.setup({})

-- tailwind lsp server
-- require('lspconfig').tailwindcss.setup({
--     capabilities = capabilities,
--     on_attach = on_attach
-- })

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌵" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
