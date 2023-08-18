vim.g.const_colorscheme = "tokyonight"

-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
    overrides = {
        SignColumn = { bg = "NONE" },

        CursorLineNR = { bg = "NONE" },
        Normal = { bg = "NONE" },


        GruvboxRedSign = { bg = "NONE" },
        GruvboxGreenSign = { bg = "NONE" },
        GruvboxYellowSign = { bg = "NONE" },
        GruvboxBlueSign = { bg = "NONE" },
        GruvboxPurpleSign = { bg = "NONE" },
        GruvboxAquaSign = { bg = "NONE" },
        GruvboxOrangeSign = { bg = "NONE" },
    },
})

require('rose-pine').setup({
    disable_background = true
})

require("tokyonight").setup({
    style = "night",
    transparent = false
})

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

vim.cmd("colorscheme " .. vim.g.const_colorscheme)
