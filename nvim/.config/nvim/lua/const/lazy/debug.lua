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
    },
    config = function()
        require("mason").setup()
        require("dapui").setup()
        require("mason-nvim-dap").setup({
            automatic_installation = false,
            ensure_installed = { "python" },
            handlers = {
                function(config)
                    require("dap.ext.vscode").load_launchjs()
                    require("mason-nvim-dap").default_setup(config)
                end,
                python = function(config)
                    config.configurations[1].justMyCode = false
                    require("mason-nvim-dap").default_setup(config)
                end
            },
        })
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
