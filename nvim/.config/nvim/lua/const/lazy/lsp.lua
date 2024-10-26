return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
        "rafamadriz/friendly-snippets",
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        require("neodev").setup({
            library = {
                enabled = true,  -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = false, -- runtime path
                types = true,    -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = false  -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            override = function(root_dir, options)
            end,
            -- With lspconfig, Neodev will automatically setup your lua-language-server
            -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
            -- in your lsp start options
            lspconfig = true,
            -- much faster, but needs a recent built of lua-language-server
            -- needs lua-language-server >= 3.6.0
            pathStrict = true
        })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({
            keymaps = {
                apply_language_filter = "ff"
            }
        })
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "gopls" },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "Lua 5.1"
                                },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" }
                                },
                                workspace = {
                                    checkThirdParty = false
                                },
                                telemetry = {
                                    enable = false
                                }
                            }
                        }
                    }
                end,
                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
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
                    }
                end,
                ["texlab"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.texlab.setup({
                        capabilities = capabilities,
                        settings = {
                            texlab = {
                                bibtexFormatter = "texlab",
                                build = {
                                    -- args = { "-pdflua", "-pvc", "-bibtex", "-auxdir=./AUX", "-interaction=nonstopmode", "-synctex=1", "%f" },
                                    args = { "-pdflua", "-pvc", "-bibtex", "-auxdir=./AUX", "-interaction=nonstopmode",
                                        "%f" },
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
                end,
                ["ltex"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ltex.setup({
                        capabilities = capabilities,
                        on_attach = function()
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
                end
            }
        })

        local signs = { {
            name = "DiagnosticSignError",
            text = ""
        }, {
            name = "DiagnosticSignWarn",
            text = ""
        }, {
            name = "DiagnosticSignHint",
            text = "󰌵"
        }, {
            name = "DiagnosticSignInfo",
            text = ""
        } }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, {
                texthl = sign.name,
                text = sign.text,
                numhl = ""
            })
        end

        local cmp_select = {
            behavior = cmp.SelectBehavior.Select
        }

        local luasnip = require("luasnip")
        local luasnip_vscode = require("luasnip/loaders/from_vscode")
        luasnip_vscode.lazy_load({
            paths = { "./snippets" }
        })
        luasnip_vscode.lazy_load()

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
            Misc = " "
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = {
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                },
                ['<CR>'] = cmp.mapping.confirm({
                    select = true
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
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
                end, { "i", "s" })
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    -- NOTE: order matters
                    vim_item.menu = ({
                        -- nvim_lsp = "[LSP]",
                        -- nvim_lua = "[Nvim]",
                        -- luasnip = "[Snippet]",
                        -- buffer = "[Buffer]",
                        -- path = "[Path]",
                        -- emoji = "[Emoji]",

                        -- nvim_lsp = "",
                        -- nvim_lua = "",
                        -- luasnip = "",
                        -- buffer = "",
                        -- path = "",
                        -- emoji = "",
                    })[entry.source.name]
                    return vim_item
                end
            },
            sources = { {
                name = 'nvim_lsp'
            }, {
                name = 'luasnip'
            }, {
                name = 'buffer'
            }, {
                name = 'path'
            } }
        })
    end
}
