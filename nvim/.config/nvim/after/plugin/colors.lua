vim.g.const_colorscheme = "gruvbox"
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


vim.cmd("colorscheme " .. vim.g.const_colorscheme)

