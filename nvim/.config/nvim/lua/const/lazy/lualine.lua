return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"kyazdani42/nvim-web-devicons", "folke/tokyonight.nvim"},
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto"
            }
        })
    end
}
