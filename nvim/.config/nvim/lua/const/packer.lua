return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Git plugins  TODO: Choose which one to use in future
    use("TimUntersberger/neogit")
    use("tpope/vim-fugitive")

    -- TJ created lodash of neovim
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    use("kyazdani42/nvim-web-devicons")

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    })

    -- Language server support
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")

    -- Snippets
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")


    use("ThePrimeagen/harpoon")


    -- Colorscheme section
    use("ellisonleao/gruvbox.nvim")
    use("folke/tokyonight.nvim")
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use("nvim-treesitter/playground")

    use({
        "AckslD/nvim-neoclip.lua",
        requires = { { "nvim-telescope/telescope.nvim" } },
        config = function()
            require('neoclip').setup({
                keys = {
                    telescope = {
                        i = {
                            select = '<cr>',
                            paste = '<c-k>',
                            paste_behind = '<c-K>',
                            custom = {},
                        }
                    }
                }
            })
        end
    })

    use("romgrk/nvim-treesitter-context")


    use("folke/todo-comments.nvim")

    -- File explorer
    use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    })

    -- use({
    --     "jpalardy/vim-slime",
    --     ft = { "python" }
    -- })

    -- use({
    --     "hanschen/vim-ipython-cell",
    --     ft = { "python" }
    -- })

    use("jose-elias-alvarez/null-ls.nvim")

    use("barreiroleo/ltex_extra.nvim")

    use({
        "rcarriga/nvim-notify",
        requires = { { "nvim-telescope/telescope.nvim" } },
        config = function()
            local log = require("plenary.log").new {
                plugin = "notify",
                level = "debug",
                use_console = false,
            }

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(msg, level, opts)
                log.info(msg, level, opts)
                if string.find(msg, "method .* is not supported") then
                    return
                end

                require "notify" (msg, level, opts)
            end
        end,
    })

    use("mbbill/undotree")

    use('simrat39/symbols-outline.nvim')

    use("folke/neodev.nvim")

    -- local packages (in development)
    use("~/Documents/Coding/ipython-tmux.nvim")
end)
