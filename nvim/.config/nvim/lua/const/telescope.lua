local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

	previewer = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

	layout_config = {
		preview_cutoff = 1,
	},

        mappings = {
            i = {
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-w>"] = "delete_buffer",
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("neoclip")
require("neoclip").setup({
    keys = {
        telescope = {
            i = {
              select = '<cr>',
              paste = '<c-k>',
              paste_behind = '<c-K>',
              custom = {},
            }
        }
    }
})

require("telescope").load_extension("dap")
