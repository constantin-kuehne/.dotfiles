local telescope = require("telescope")

telescope.setup({
    defaults = {
        file_ignore_patterns = { ".git/" }
    }
})

telescope.load_extension("neoclip")
