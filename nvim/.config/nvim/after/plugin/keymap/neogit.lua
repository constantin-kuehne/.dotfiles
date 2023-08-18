local Remap = require("const.keymap")
local nnoremap = Remap.nnoremap
local neogit = require('neogit')

-- nnoremap("<leader>gs", function()
--     neogit.open({ })
-- end);

nnoremap("<leader>ga", "<cmd>!git fetch --all<CR>");
