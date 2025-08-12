local used_spaces_table = {}

--- @class get_used_space.opt
--- @field exclude string[]
--- @param opts get_used_space.opt value to exclude.
local function get_used_space(opts)
    local used_space = 0
    for k, v in pairs(used_spaces_table) do
        if vim.tbl_contains(opts.exclude, k) then
            goto continue
        end
        used_space = used_space + v
        ::continue::
    end
    return used_space
end

local components = {
    mode = {
        "mode",
        fmt = function(str)
            local evaled_str = vim.api.nvim_eval_statusline(str, {})
            if str == "" then
                used_spaces_table["mode"] = 0
            else
                used_spaces_table["mode"] = #evaled_str.str + 2 -- 2 is the length of padding
            end
            return str
        end,
    },
    branch = {
        "branch",
        cond = function()
            local should_show = vim.opt.columns:get() > 60
            if not should_show then
                used_spaces_table["branch"] = 0
            end
            return should_show
        end,
        fmt = function(str)
            local evaled_str = vim.api.nvim_eval_statusline(str, {})
            if str == "" then
                used_spaces_table["branch"] = 0
            else
                used_spaces_table["branch"] = #evaled_str.str + 2 +
                    2 -- 2 is the length of padding, 2 is the length of the icon
            end
            return str
        end,
    },
    diff = {
        "diff",
        fmt = function(str)
            if str == "" then
                used_spaces_table["diff"] = 0
            else
                local evaled_str = vim.api.nvim_eval_statusline(str, {}).str
                used_spaces_table["diff"] = vim.fn.strchars(evaled_str) + 2 -- 2 is the length of padding
            end
            return str
        end,
        separator = "",
    },
    filename = {
        "filename",
        fmt = function(filename)
            if filename == "" then
                used_spaces_table["filename"] = 0
                return ""
            end
            local evaled_str = vim.api.nvim_eval_statusline(filename, {})
            if evaled_str.str == "" then
                used_spaces_table["filename"] = 0
                return ""
            end
            used_spaces_table["filename"] = vim.fn.strchars(evaled_str.str) -- 2 is the length of padding
            return filename
        end,
        path = 0,
        padding = { left = 0, right = 0 },
        separator = "",
    },
    harpoon = {
        "harpoon2",
        icon = "󰀱",
        _separator = " ",
        indicators = { "1", "2", "3", "4", "5" },
        -- active_indicators = { "𝟭", "𝟮", "𝟯", "𝟰", "𝟱" }, -- Using Unicode bold digits
        active_indicators = { "1", "2", "3", "4", "5" },
        no_harpoon = "Harpoon not loaded",
        color_active = {
            fg = "#7aa2f7",
            gui = "bold",
        },
        separator = "",
        fmt = function(str)
            if str == "" then
                used_spaces_table["harpoon"] = 0
                return ""
            end
            used_spaces_table["harpoon"] = 11 + 2 +
                2 -- 11 is the max length of the indicators, 2 is the length of padding and 2 is the length of the icon
            return str
        end,
    },
    fill_space = {
        function()
            local used_space = used_spaces_table["mode"] + used_spaces_table["branch"] + used_spaces_table["filename"] +
                used_spaces_table["filetype"]
            local win_width = vim.opt.columns:get()
            local fill_space = string.rep(
                " ",
                math.floor((win_width - used_spaces_table["harpoon"]) / 2) - (used_space)
            )
            return fill_space
        end,
        cond = function() return vim.opt.columns:get() > 60 end,
        fmt = function(str)
            local evaled_str = vim.api.nvim_eval_statusline(str, {})
            if str == "" then
                used_spaces_table["fill_space"] = 0
            else
                used_spaces_table["fill_space"] = #evaled_str.str
            end
            return str
        end,
        separator = "",
        padding = { left = 0, right = 0 },
    },
    filetype = {
        "filetype",
        fmt = function(str)
            if str == "" then
                used_spaces_table["filetype"] = 0
            else
                used_spaces_table["filetype"] = 2 + 1 -- 2 is the length of all icons, 1 is the padding
            end
            return str
        end,
        icon_only = true,
        separator = "",
        padding = { left = 1, right = 0 },
    },
    diagnostics = {
        "diagnostics",
        fmt = function(str)
            local evaled_str = vim.api.nvim_eval_statusline(str, {})
            if str == "" then
                used_spaces_table["diagnostics"] = 0
            else
                used_spaces_table["diagnostics"] = vim.fn.strchars(evaled_str.str) + 2
            end
            return str
        end,
        separator = "",
    },
    progress = {
        "progress",
        fmt = function(str)
            local evaled_str = vim.api.nvim_eval_statusline(str, {})
            if str == "" then
                used_spaces_table["progress"] = 0
            else
                used_spaces_table["progress"] = #evaled_str.str + 2
            end
            return str
        end,
    },
    location = {
        "location",
        fmt = function(str)
            local evaled_str = vim.api.nvim_eval_statusline(str, {})
            if str == "" then
                used_spaces_table["location"] = 0
            else
                used_spaces_table["location"] = #evaled_str.str + 2 -- 2 is the length of padding
            end
            return str
        end,
    },
}


return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {
            "echasnovski/mini.icons",
            config = function()
                require('mini.icons').setup()
                MiniIcons.mock_nvim_web_devicons()
            end
        },
        "folke/tokyonight.nvim"
    },
    config = function()
        local sections = {
            lualine_a = {
                components.mode,
            },
            lualine_b = {
                components.branch,
            },
            lualine_c = {
                components.filetype,
                components.filename,
                components.fill_space,
                components.harpoon,
            },
            lualine_x = {
                { require("lualine.components.ai-status"), separator = "" },
                components.diagnostics,
                components.diff,
            },
            lualine_y = {
                components.progress,
            },
            lualine_z = {
                components.location,
            },
        }
        require("lualine").setup({
            options = {
                theme = "auto",
                globalstatus = true,
                always_divide_middle = false,
            },
            sections = sections,
        })
    end
}
