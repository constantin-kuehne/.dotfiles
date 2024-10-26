return {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    config = function()
        vim.g.molten_virt_text_output = true
        vim.g.molten_auto_open_output = false
        local notebook = require("notebook")
        notebook.use_molten()
    end
}
