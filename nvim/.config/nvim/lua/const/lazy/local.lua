local local_plugins = {{
    "ipython-tmux",
    dir = "~/Documents/Coding/ipython-tmux.nvim",
    config = function()
        require("ipython-tmux").setup()
    end
}, {
    "notebook",
    dir = "~/Documents/Coding/notebook.nvim"
}}

return local_plugins
