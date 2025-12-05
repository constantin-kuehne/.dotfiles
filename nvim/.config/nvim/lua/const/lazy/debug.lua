return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "mason-org/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio"
    },
    lazy = true,
    cmd = {
        "DapContinue",
        "DapPythonRunArgs",
        "DapDisconnect",
        "DapNew",
        "DapTerminate",
        "DapRestartFrame",
        "DapStepInto",
        "DapStepOut",
        "DapStepOver",
        "DapPause",
        "DapEval",
        "DapToggleRepl",
        "DapClearBreakpoints",
        "DapToggleBreakpoint",
        "DapToggleBreakpointCondition",
        "DapSetLogLevel",
        "DapShowLog",
        "DapInstall",
        "DapUninstall",
        "DapUIToggle",
    },
    config = function()
        --- @type MasonNvimDapSettings
        require("mason-nvim-dap").setup({
            automatic_installation = false,
            ensure_installed = { "python" },
            handlers = {
                function(config)
                    local old_get_configs = require("dap.ext.vscode").getconfigs
                    require("dap.ext.vscode").getconfigs = function(ft)
                        local configs = old_get_configs(ft)
                        local new_configs = {}
                        for _, c in ipairs(configs) do
                            local new_c = vim.tbl_deep_extend("force", config.configurations[1], c)
                            new_c = setmetatable(new_c, {
                                __call = function()
                                    debug.setupvalue(getmetatable(c).__call, 1, new_c)     -- this is very hacky but works (I replace the deepcopy of the original config with the new one)
                                    return getmetatable(c).__call()
                                end
                            })
                            table.insert(new_configs, new_c)
                        end
                        return new_configs
                    end
                    require("mason-nvim-dap").default_setup(config)
                end,
                python = function(config)
                    config.configurations[1].justMyCode = false
                    config.configurations[1].env = { PYTHONPATH = "${workspaceFolder}" }
                    config.configurations[1].cwd = "${workspaceFolder}"

                    local old_get_configs = require("dap.ext.vscode").getconfigs
                    require("dap.ext.vscode").getconfigs = function(ft)
                        local configs = old_get_configs(ft)
                        local new_configs = {}
                        for _, c in ipairs(configs) do
                            if c.type == "python" then
                                local new_c = vim.tbl_deep_extend("force", config.configurations[1], c)
                                new_c = setmetatable(new_c, {
                                    __call = function()
                                        debug.setupvalue(getmetatable(c).__call, 1, new_c) -- this is very hacky but works (I replace the deepcopy of the original config with the new one)
                                        return getmetatable(c).__call()
                                    end
                                })
                                table.insert(new_configs, new_c)
                            end
                        end
                        return new_configs
                    end
                    -- config.configurations[1].args = function()
                    --     local input = vim.fn.input("Args: ")
                    --     return vim.split(input, " ")
                    -- end
                    require("mason-nvim-dap").default_setup(config)
                end
            },
        })

        require("mason").setup()
        require("dapui").setup()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        vim.api.nvim_create_user_command("DapToggleBreakpointCondition", function()
            local condition = vim.fn.input("Condition: ")
            if condition == "" then
                vim.notify("No condition provided, removing breakpoint condition.")
                require("dap").toggle_breakpoint(nil, nil, nil)
            else
                require("dap").set_breakpoint(condition)
            end
        end, { desc = "Toggle DAP Breakpoint Condition" })

        vim.api.nvim_create_user_command("DapAddToWatches", function()
            require('dapui').elements.watches.add(vim.fn.expand('<cword>'))
        end, { desc = "Add variable under the cursor to watches" })

        vim.api.nvim_create_user_command("DapUIToggle", function()
            require("dapui").toggle()
        end, { desc = "Toggle DAP UI" })

        vim.api.nvim_create_user_command("DapPythonRunArgs", function(args)
            local config = require("dap").configurations.python[1]
            config.args = args.fargs
            require("dap").run(config)
        end, { desc = "Run with args", nargs = "*" })

        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "󰯲", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DapLogPoint", { text = "󰰍", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignHint" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })


        -- dap.listeners.before.event_terminated.dapui_config = function()
        --     dapui.close()
        -- end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     dapui.close()
        -- end
    end
}
