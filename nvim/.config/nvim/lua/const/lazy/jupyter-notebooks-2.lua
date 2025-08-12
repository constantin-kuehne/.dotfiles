vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = function()
        if vim.fn.has("python3") == 0 then
            vim.notify("Opening ipynb without python3", vim.log.levels.ERROR)
        end
    end,
})

return {
    {
        "benlubas/molten-nvim",
        build = ":UpdateRemotePlugins",
        ft = { "markdown", "rmd", "quarto" },
        cond = function()
            return vim.fn.has("python3") == 1
        end,
        init = function()
            -- I find auto open annoying, keep in mind setting this option will require setting
            -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
            vim.g.molten_auto_open_output = false

            -- this guide will be using image.nvim
            -- Don't forget to setup and install the plugin if you want to view image outputs
            vim.g.molten_image_provider = "snacks.nvim"

            -- optional, I like wrapping. works for virt text and the output window
            vim.g.molten_wrap_output = true

            vim.g.molten_output_win_border = { "", "", "", "│", "", "", "", "" }
            vim.g.molten_output_win_cover_gutter = false
            vim.g.molten_output_win_style = "minimal"
            vim.g.molten_use_border_highlights = false

            vim.g.molten_output_virt_lines = true
            vim.g.molten_cover_empty_lines = true

            -- Output as virtual text. Allows outputs to always be shown, works with images, but can
            -- be buggy with longer images
            vim.g.molten_virt_text_output = true

            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = true

            vim.api.nvim_set_hl(0, "MoltenOutputBorder", { link = "DiagnosticHint" })
            vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { link = "DiagnosticError" })
            vim.api.nvim_set_hl(0, "MoltenOutputBorderSuccess", { link = "DiagnosticOk" })
            vim.api.nvim_set_hl(0, "MoltenCell", { link = "Normal" })


            -- automatically import output chunks from a jupyter notebook
            -- tries to find a kernel that matches the kernel in the jupyter notebook
            -- falls back to a kernel that matches the name of the active venv (if any)
            local imb = function(e) -- init molten buffer
                vim.schedule(function()
                    local kernels = vim.fn.MoltenAvailableKernels()
                    local try_kernel_name = function()
                        local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
                        return metadata.kernelspec.name
                    end
                    local ok, kernel_name = pcall(try_kernel_name)
                    if not ok or not vim.tbl_contains(kernels, kernel_name) then
                        kernel_name = nil
                        local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
                        if venv ~= nil then
                            kernel_name = string.match(venv, "/.+/(.+)")
                        end
                    end
                    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
                        vim.cmd(("MoltenInit %s"):format(kernel_name))
                    end
                    vim.cmd("MoltenImportOutput")
                end)
            end

            -- automatically import output chunks from a jupyter notebook
            vim.api.nvim_create_autocmd("BufAdd", {
                pattern = { "*.ipynb" },
                callback = imb,
            })

            -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.ipynb" },
                callback = function(e)
                    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
                        imb(e)
                    end
                end,
            })

            -- automatically export output chunks to a jupyter notebook on write
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.ipynb" },
                callback = function()
                    if require("molten.status").initialized() == "Molten" then
                        vim.cmd("MoltenExportOutput!")
                    end
                end,
            })

            -- change the configuration when editing a python file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*.py",
                callback = function(e)
                    if string.match(e.file, ".otter.") then
                        return
                    end
                    if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
                        vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("virt_text_output", false)
                    else
                        vim.g.molten_virt_lines_off_by_1 = false
                        vim.g.molten_virt_text_output = false
                    end
                end,
            })

            -- Undo those config changes when we go back to a markdown or quarto file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.qmd", "*.md", "*.ipynb" },
                callback = function(e)
                    if string.match(e.file, ".otter.") then
                        return
                    end
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
                        vim.fn.MoltenUpdateOption("virt_text_output", true)
                    else
                        vim.g.molten_virt_lines_off_by_1 = true
                        vim.g.molten_virt_text_output = true
                    end
                end,
            })

            -- Provide a command to create a blank new Python notebook
            -- note: the metadata is needed for Jupytext to understand how to parse the notebook.
            -- if you use another language than Python, you should change it in the template.
            local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

            local function new_notebook(filename)
                local path = filename .. ".ipynb"
                local file = io.open(path, "w")
                if file then
                    file:write(default_notebook)
                    file:close()
                    vim.cmd("edit " .. path)
                else
                    print("Error: Could not open new notebook file for writing.")
                end
            end

            vim.api.nvim_create_user_command('NewNotebook', function(opts)
                new_notebook(opts.args)
            end, {
                nargs = 1,
                complete = 'file'
            })
        end
    },
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                ft = { "markdown", "rmd", "quarto" },
                config = function()
                    require("otter").setup({
                    })
                end
            },
            "nvim-treesitter/nvim-treesitter",
        },
        ft = { "markdown", "rmd", "quarto" },
        cond = function()
            return vim.fn.has("python3") == 1
        end,
        config = function()
            local quarto = require("quarto")
            quarto.setup({
                lspFeatures = {
                    languages = { "r", "python", "rust" },
                    chunks = "all",
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                },
            })
            require("quarto").activate()

            vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
                pattern = { "*.qmd", "*.md", "*.rmd" },
                callback = function(args)
                    local win = vim.api.nvim_get_current_win()
                    local config = vim.api.nvim_win_get_config(win)
                    local is_floating = config.relative == "win"

                    local is_correct_ft = vim.list_contains({ "markdown", "quarto", "rmd", }, vim.bo[args.buf].filetype)

                    if not is_floating and is_correct_ft then
                        require("otter").activate()
                    end
                end,
            })
        end
    },
    {
        "GCBallesteros/jupytext.nvim",
        cond = function()
            return vim.fn.has("python3") == 1
        end,
        config = function()
            require("jupytext").setup({
                style = "markdown",
                output_extension = "md",
                force_ft = "markdown",
            })
        end
    },
    {
        "nvimtools/hydra.nvim",
        ft = { "markdown", "rmd", "quarto" },
        dependencies = {
            {
                "quarto-dev/quarto-nvim",
                ft = { "markdown", "rmd", "quarto"
                }
            }
        },
        cond = function()
            return vim.fn.has("python3") == 1
        end,
        config = function()
            -- vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>",
            --     { desc = "evaluate operator", silent = true })
            -- vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>",
            --     { desc = "open output window", silent = true })
            -- vim.keymap.set("n", "<leader>rc", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
            -- vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
            --     { desc = "execute visual selection", silent = true })
            -- vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>",
            --     { desc = "close output window", silent = true })
            -- vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

            -- -- if you work with html outputs:
            -- vim.keymap.set("n", "<leader>mx", ":MoltenOpenInBrowser<CR>",
            --     { desc = "open output in browser", silent = true })

            -- vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
            -- vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
            -- vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "run all cells", silent = true })
            -- vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
            -- vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
            -- vim.keymap.set("n", "<leader>RA", function()
            --     runner.run_all(true)
            -- end, { desc = "run all cells of all languages", silent = true })

            local function keys(str)
                return function()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
                end
            end

            local function get_previous_cell_end()
                local ts = vim.treesitter

                local bufnr = vim.api.nvim_get_current_buf()
                local lang = "markdown"

                local parser = ts.get_parser(bufnr, lang)
                local tree = parser:parse()[1]
                local root = tree:root()

                local q = ts.query.get(lang, "textobjects")

                local cursor_row = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1]

                local closest = nil

                for id, node, metadata, match in q:iter_captures(root, bufnr, 0, cursor_row) do
                    if q.captures[id] == "code_cell.outer" then
                        local start_row, start_col, end_row, end_col = node:range()
                        if cursor_row >= start_row and cursor_row <= end_row then
                            return end_row
                        end
                        if closest == nil or end_row > closest then
                            closest = end_row
                        end
                    end
                end

                return closest
            end

            local function new_cell()
                local bufnr = vim.api.nvim_get_current_buf()
                local winnr = vim.api.nvim_get_current_win()

                local prev_cell_end = get_previous_cell_end()
                local row_insert = nil

                if prev_cell_end == nil then
                    row_insert, _ = unpack(vim.api.nvim_win_get_cursor(winnr))
                else
                    row_insert = prev_cell_end + 1
                end

                local lines_to_insert = {
                    "```python",
                    "",
                    "```",
                    ""
                }
                vim.api.nvim_buf_set_lines(bufnr, row_insert, row_insert, false, lines_to_insert)
                vim.api.nvim_win_set_cursor(0, { row_insert + 2, 0 })
            end

            local runner = require('quarto.runner')

            local hydra = require("hydra")

            hydra({
                name = "QuartoNavigator",
                hint = [[
                            _j_/_k_: move down/up
_r_: run cell               _A_: run all cells      _a_/_b_: run above/below
_l_: run line               _x_: open browser       _d_: delete cell
_o_/_h_: toggle output        _t_: toggle virt text   _n_: new cell
                            _<esc>_/_q_: exit ]],
                config = {
                    color = "pink",
                    invoke_on_body = true,
                },
                mode = { "n" },
                body = "<leader>j", -- this is the key that triggers the hydra
                heads = {
                    { "j", keys("]b"), { desc = "next cell" } },
                    { "k", keys("[b"), { desc = "previus cell" } },
                    { "r", function()
                        runner.run_cell(false)
                    end
                    , { desc = "run cell" } },
                    { "A", function()
                        runner.run_all(true)
                    end
                    , { desc = "run all cells", silent = true } },
                    { "l",     runner.run_line,                    { desc = "run line" } },
                    { "a",     runner.run_above,                   { desc = "run cell and above" } },
                    { "b",     runner.run_below,                   { desc = "run cell and below" } },
                    { "o",     ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true, exit = true } },
                    { "h",     ":MoltenHideOutput<CR>",            { desc = "close output window", silent = true, exit = true } },
                    { "x",     ":MoltenOpenInBrowser<CR>",         { desc = "open output in browser" } },
                    { "d",     ":MoltenDelete<CR>",                { desc = "delete Molten cell" } },
                    { "t",     ":MoltenToggleVirtual<CR>",         { desc = "toggle virt text", silent = true } },
                    { "n",     new_cell,                           { desc = "create new cell", exit = true } },
                    { "<esc>", nil,                                { exit = true } },
                    { "q",     nil,                                { exit = true } },
                },
            })
        end
    }
}
