local nnoremap = require("const.keymap").nnoremap
local builtin = require("telescope.builtin")

nnoremap("<leader>ff", function ()
   builtin.find_files({hidden = true})
end)
nnoremap("<leader>fl", builtin.live_grep)
nnoremap("<leader>fb", builtin.buffers)
nnoremap("<leader>fh", builtin.help_tags)
nnoremap("<leader>fg", builtin.git_files)

-- Telescope extensions
nnoremap("<leader>fc", "<cmd>Telescope neoclip<cr>")
