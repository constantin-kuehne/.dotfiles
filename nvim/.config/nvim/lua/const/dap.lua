require('telescope').load_extension('dap')
local dapui = require("dapui")

dapui.setup()

local dap = require("dap")
local utils = require('const.utils')

dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {os.getenv('HOME') .. '/.config/nvim/debugAdapter.js'};
}
dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}

-- remove debugging keymaps
local function remove_maps()
    -- utils.unmap('n', '<m-d>B')
    -- utils.unmap({'n', 'v'}, '<m-d>k')
    -- utils.unmap('n', '<m-1>')
    -- utils.unmap('n', '<m-2>')
    -- utils.unmap('n', '<m-3>')
    -- utils.unmap('n', '<m-q>')
    utils.unmap('n', '<f4>')
    utils.unmap('n', '<f3>')
end

local function terminate_session()
    remove_maps()
    dapui.close()
    dap.repl.close()
end

-- setup debugging keymaps
local function setup_maps()
    -- utils.map('n', '<m-d>B', function()
    --     local condition = vim.fn.input('breakpoint condition: ')
    --     if condition then dap.set_breakpoint(condition) end
    -- end)

    -- utils.map({'n', 'v'}, '<m-d>k', dapui.eval)
    -- utils.map('n', '<m-1>', dap.step_over)
    -- utils.map('n', '<m-2>', dap.step_into)
    -- utils.map('n', '<m-3>', dap.step_out)

    utils.map('n', '<leader>dcl', function()

        remove_maps()
        dapui.close()
        dap.repl.close()
        dap.close()
    end)

    utils.map('n', '<f3>', terminate_session)

    utils.map('n', '<f4>', dapui.toggle)
end

-- start session: setup keymaps, open dapui
local function start_session()
    -- set session tab

    setup_maps()
    dapui.open()
end

-- terminate session: remove keymaps, close dapui, close dap repl,
-- close internal_servers, set last output buffer active

-- dap events
dap.listeners.after.event_initialized["dapui"] = start_session
-- dap.listeners.before.event_terminated["dapui"] = terminate_session
-- dap.listeners.before.event_exited["dapui"] = terminate_session

-- signs
vim.fn.sign_define("DapStopped", {text = '=>', texthl = 'DiagnosticWarn'})
vim.fn.sign_define("DapBreakpoint", {text = '<>', texthl = 'DiagnosticInfo'})
vim.fn.sign_define("DapBreakpointRejected", {text = '!>', texthl = 'DiagnosticError'})
vim.fn.sign_define("DapBreakpointCondition", {text = '?>', texthl = 'DiagnosticInfo'})
vim.fn.sign_define("DapLogPoint", {text = '.>', texthl = 'DiagnosticInfo'})

-- general keymaps
utils.map('n', '<f5>', function()
    dap.continue()
end)

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

utils.map('n', '<f9>', function()
    print(dump(dap.session()))
end)

return {remove_maps = remove_maps, setup_maps = setup_maps}
