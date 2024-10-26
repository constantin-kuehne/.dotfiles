return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- dependencies = {"nvim-treesitter/playground", "romgrk/nvim-treesitter-context"},
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {"vimdoc", "vim", "python", "lua"},

            sync_install = false,

            indent = {
                enable = true
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },

            disable = {"json", "notebook", "ipynb"}
        })
    end

}
