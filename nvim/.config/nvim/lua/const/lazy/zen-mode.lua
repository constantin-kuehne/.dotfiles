return {
    "folke/zen-mode.nvim",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        window = {
            width = .70
        },
        plugins = {
            options = {
                enabled = true,
                ruler = true,
                showcmd = true,
                laststatus = 0,
            },
            tmux = {
                enabled = true,
            },
        }
    }
}
