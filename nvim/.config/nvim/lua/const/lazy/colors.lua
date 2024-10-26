function ColorMyPencils(color)
    color = color or "tokyonight"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", {
        bg = "none"
    })
    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "none"
    })
end

return {
    { "erikbackman/brightburn.vim" }, {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    config = function()
        require("gruvbox").setup({
            overrides = {
                SignColumn = {
                    bg = "NONE"
                },

                CursorLineNR = {
                    bg = "NONE"
                },
                Normal = {
                    bg = "NONE"
                },

                GruvboxRedSign = {
                    bg = "NONE"
                },
                GruvboxGreenSign = {
                    bg = "NONE"
                },
                GruvboxYellowSign = {
                    bg = "NONE"
                },
                GruvboxBlueSign = {
                    bg = "NONE"
                },
                GruvboxPurpleSign = {
                    bg = "NONE"
                },
                GruvboxAquaSign = {
                    bg = "NONE"
                },
                GruvboxOrangeSign = {
                    bg = "NONE"
                }
            }
        })
    end
}, {
    "folke/tokyonight.nvim",
    lazy = false,
    name = "tokyonight",
    config = function()
        require("tokyonight").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            style = "night",    -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            transparent = false -- Enable this to disable setting the background color
        })
        ColorMyPencils()
    end
}, {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require('rose-pine').setup({
            disable_background = true,
            styles = {
                italic = false
            }
        })

        ColorMyPencils();
    end
} }
