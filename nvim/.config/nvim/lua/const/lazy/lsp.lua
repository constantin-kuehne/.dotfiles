return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },

            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "rafamadriz/friendly-snippets",
            {
                "saghen/blink.cmp",
                enabled = false,
                version = 'v0.*',
                opts = {
                    -- 'default' for mappings similar to built-in completion
                    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                    -- see the "default configuration" section below for full documentation on how to define
                    -- your own keymap.
                    keymap = { preset = 'default' },
                    appearance = {
                        use_nvim_cmp_as_default = true,
                        nerd_font_variant = 'mono'
                    },
                    sources = {
                        default = { 'lsp', 'path', 'snippets', 'buffer' },
                    },
                    signature = { enabled = true }
                },
                opts_extend = { "sources.default" }
            },
            {
                "hrsh7th/nvim-cmp",
                enabled = true,
                dependencies = {
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline",
                }
            },
            {
                "L3MON4D3/LuaSnip",
                enabled = true,
                build = "make install_jsregexp",
                dependencies = {
                    "saadparwaiz1/cmp_luasnip",
                },
                config = function()
                    local luasnip_vscode = require("luasnip.loaders.from_vscode")
                    luasnip_vscode.lazy_load() -- for friendly snippets
                    luasnip_vscode.lazy_load({
                        paths = { "./snippets" },

                    })
                end,
            },
            -- "j-hui/fidget.nvim",
            "nvim-telescope/telescope.nvim",
            "barreiroleo/ltex_extra.nvim"
        },
        config = function()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )
            -- local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- require("fidget").setup({})
            require("mason").setup({
                ui = {
                    keymaps = {
                        apply_language_filter = "ff",
                    }
                }
            })

            local function on_attach(client, bufnr)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end


            local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = { "gopls", "julials", "basedpyright" },
                handlers = {
                    function(server_name) -- default handler (optional)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach
                        })
                    end,
                    ["julials"] = function()
                        lspconfig.julials.setup({
                            capabilities = (function()
                                local capabilities = vim.lsp.protocol.make_client_capabilities()
                                capabilities.textDocument.completion.completionItem.snippetSupport = true
                                capabilities.textDocument.completion.completionItem.preselectSupport = true
                                capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
                                capabilities.textDocument.completion.completionItem.deprecatedSupport = true
                                capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
                                capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
                                capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
                                capabilities.textDocument.completion.completionItem.resolveSupport = {
                                    properties = { "documentation", "detail", "additionalTextEdits" },
                                }
                                capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown" }
                                capabilities.textDocument.codeAction = {
                                    dynamicRegistration = true,
                                    codeActionLiteralSupport = {
                                        codeActionKind = {
                                            valueSet = (function()
                                                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                                                table.sort(res)
                                                return res
                                            end)(),
                                        },
                                    },
                                }
                                return capabilities
                            end)(),
                            on_attach = function(client, bufnr)
                                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                            end,
                            on_new_config = function(new_config, _)
                                local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
                                if (vim.loop.fs_stat(julia) or {}).type == 'file' then
                                    new_config.cmd[1] = julia
                                end
                            end,
                        })
                    end,
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "Lua 5.1",
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = true,
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                        })
                    end,
                    ["pyright"] = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                python = {
                                    -- Settings: https://github.com/microsoft/pyright/blob/main/docs/settings.md#pyright-settings
                                    pythonPath = "python",
                                    analysis = {
                                        typeCheckingMode = "off",
                                        pythonVersion = "3.9",
                                        -- Configuration: https://github.com/microsoft/pyright/blob/main/docs/configuration.md#diagnostic-rule-defaults
                                        diagnosticSeverityOverrides = {
                                            reportUnusedExpression = "none",
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    ["basedpyright"] = function()
                        lspconfig.basedpyright.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                python = {
                                    pythonPath = "python",
                                },
                                basedpyright = {
                                    analysis = {
                                        typeCheckingMode = "basic",
                                        diagnosticMode = "workspace",
                                        autoSearchPaths = true,
                                        autoImportCompletions = true,
                                        inlayHints = {
                                            variableTypes = true,
                                            callArgumentNames = true,
                                            functionReturnTypes = true,
                                            genericTypes = true,
                                        },
                                        diagnosticSeverityOverrides = {
                                            ["reportUnusedExpression"] = "none",
                                        },
                                    },
                                },
                            }
                        })
                        -- vim.print(lspconfig.basedpyright.)
                    end,
                    ["texlab"] = function()
                        lspconfig.texlab.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                texlab = {
                                    bibtexFormatter = "texlab",
                                    build = {
                                        -- args = { "-pdflua", "-pvc", "-bibtex", "-auxdir=./AUX", "-interaction=nonstopmode", "-synctex=1", "%f" },
                                        args = {
                                            "-pdflua",
                                            "-pvc",
                                            "-bibtex",
                                            "-auxdir=./AUX",
                                            "-interaction=nonstopmode",
                                            "%f",
                                        },
                                        executable = "latexmk",
                                        auxDirectory = "./AUX",
                                        logDirectory = "./AUX",
                                        forwardSearchAfter = false,
                                        onSave = false,
                                    },
                                    chktex = {
                                        onEdit = false,
                                        onOpenAndSave = false,
                                    },
                                    diagnosticsDelay = 200,
                                    formatterLineLength = 80,
                                    forwardSearch = {
                                        args = {},
                                    },
                                    latexFormatter = "latexindent",
                                    latexindent = {
                                        modifyLineBreaks = false,
                                    },
                                },
                            },
                        })
                    end,
                    ["ltex"] = function()
                        lspconfig.ltex.setup({
                            capabilities = capabilities,
                            on_attach = function(client, bufnr)
                                on_attach(client, bufnr)
                                require("ltex_extra").setup({
                                    load_langs = { "en-GB", "de-DE" },
                                    init_check = true,
                                    path = vim.fn.expand("~") .. "/.local/share/ltex",
                                })
                            end,
                            settings = {
                                ltex = {
                                    language = "en-GB",
                                },
                            },
                            autostart = false,
                        })
                    end,
                },
            })

            local signs = {
                {
                    name = "DiagnosticSignError",
                    text = "",
                },
                {
                    name = "DiagnosticSignWarn",
                    text = "",
                },
                {
                    name = "DiagnosticSignHint",
                    text = "󰌵",
                },
                {
                    name = "DiagnosticSignInfo",
                    text = "",
                },
            }


            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, {
                    texthl = sign.name,
                    text = sign.text,
                    numhl = "",
                })
            end

            local cmp_select = {
                behavior = cmp.SelectBehavior.Select,
            }

            local luasnip = require("luasnip")

            local kind_icons = {
                Text = "󰉿",
                Method = "m",
                Function = "󰊕",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "󰌗",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
                Misc = " ",
                Copilot = "⛮",
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,
                    }),
                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expandable() then
                    --         luasnip.expand()
                    --     elseif luasnip.expand_or_locally_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Kind icons
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        -- NOTE: order matters
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Nvim]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            emoji = "[Emoji]",
                            copilot = "[Copilot]",

                            -- nvim_lsp = "",
                            -- nvim_lua = "",
                            -- luasnip = "",
                            -- buffer = "",
                            -- path = "",
                            -- emoji = "",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    {
                        name = "nvim_lsp",
                    },
                    {
                        name = "luasnip",
                    },
                    {
                        name = "buffer",
                    },
                    {
                        name = "path",
                    },
                    {
                        name = "copilot",
                    },
                    {
                        name = "lazydev",
                        group_index = 0,
                    },
                },
            })

            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
                buffer = 0,
            })
        end,

    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim", "ThePrimeagen/refactoring.nvim" },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "isort", "black", "prettierd" },
                automatic_installation = false,
                handlers = {},
            })

            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
                buffer = 0,
            })

            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.refactoring
                }
            })
        end,
    }
}
