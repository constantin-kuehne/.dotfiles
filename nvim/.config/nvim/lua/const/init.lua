local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("const.set")
require("const.remap")
require("lazy").setup({
    spec = "const.lazy",
    change_detection = { notify = true }
})

local augroup = vim.api.nvim_create_augroup
ConstGroup = augroup('Const', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 100
        })
    end
})

local function remove_whitespace()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end

autocmd('BufWritePre', {
    group = ConstGroup,
    pattern = "*",
    callback = remove_whitespace
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

function Dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

autocmd("LspAttach", {
    group = ConstGroup,
    callback = function(e)
        local telescope_builtin = require("telescope.builtin")
        local opts = {
            buffer = e.buf
        }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- vim.keymap.set("n", "gt", vim.lsp.buf.type_defintion, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            local ext = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")

            if ext == "ipynb" then
                require("conform").format({
                    lsp_fallback = true,
                })
            else
                vim.lsp.buf.format()
            end
        end, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>dK", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>fe", telescope_builtin.diagnostics, opts)
        vim.keymap.set("n", "<leader>fi", telescope_builtin.lsp_implementations, opts)
        vim.keymap.set("n", "<leader>fd", telescope_builtin.lsp_definitions, opts)
        vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references, opts)
        vim.keymap.set("n", "<leader>ft", telescope_builtin.lsp_type_definitions, opts)
    end
})
