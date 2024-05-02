require('nvim-treesitter.configs').setup({
    ensure_installed = { "python", "lua", "go", "rust", "ocaml", "latex", "bibtex", "toml", "yaml" },

    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    disable = { "json", "notebook", "ipynb" }
})
