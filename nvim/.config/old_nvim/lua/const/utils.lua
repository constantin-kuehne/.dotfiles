-- setup keymaps
local function map(mode, lhs, rhs, opts, buffer_nr)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    if buffer_nr then options['buffer'] = buffer_nr end

    vim.keymap.set(mode, lhs, rhs, options)
end

-- remove keymaps
local function unmap(mode, lhs, buffer_nr)
    local options = {}
    if buffer_nr then options['buffer'] = buffer_nr end

    -- vim.keymap.del(mode, lhs, options)
    pcall(vim.keymap.del, mode, lhs, options)
end

return {
    map = map,
    unmap = unmap
}
