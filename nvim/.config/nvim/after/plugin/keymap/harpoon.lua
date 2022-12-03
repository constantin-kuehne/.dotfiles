local nnoremap = require("const.keymap").nnoremap
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

nnoremap("<C-h>", harpoon_mark.add_file, {silent = true})

nnoremap("<leader>1", function ()
    harpoon_ui.nav_file(1)
end, {silent = true}
)

nnoremap("<leader>2", function ()
    harpoon_ui.nav_file(2)
end, {silent = true}
)

nnoremap("<leader>3", function ()
    harpoon_ui.nav_file(3)
end, {silent = true}
)

nnoremap("<leader>3", function ()
    harpoon_ui.nav_file(3)
end, {silent = true}
)

nnoremap("<leader>4", function ()
    harpoon_ui.nav_file(4)
end, {silent = true}
)

nnoremap("<leader>,", harpoon_ui.toggle_quick_menu, {silent = true})
