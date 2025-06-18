return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {
            "echasnovski/mini.icons",
            config = function()
                require('mini.icons').setup()
                MiniIcons.mock_nvim_web_devicons()
            end
        },
        "folke/tokyonight.nvim"
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto"
            },
            sections = {
                lualine_x = {
                    require("lualine.components.ai-status")
                }
            }
        })
    end
}
