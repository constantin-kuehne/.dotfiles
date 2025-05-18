return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        require("mason").setup()
        require("dapui").setup()
        require("mason-nvim-dap").setup({
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
        -- dap.listeners.before.event_terminated.dapui_config = function()
        --     dapui.close()
        -- end
        -- dap.listeners.before.event_exited.dapui_config = function()
        --     dapui.close()
        -- end
    end
}
