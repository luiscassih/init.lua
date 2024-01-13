return {
  'mfussenegger/nvim-dap',
  event = "VeryLazy",
  enabled = false, -- disabled by default
  dependencies = {
    'rcarriga/nvim-dap-ui',
    -- 'theHamsta/nvim-dap-virtual-text',
    -- 'nvim-telescope/telescope-dap.nvim',
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    -- dap.set_log_level('TRACE')
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "Debugger: Continue" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debugger: Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debugger: Terminate" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debugger: Step over" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debugger: Step into" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debugger: Step out" })
    vim.keymap.set({ "n", "v" }, "<leader>dh", dapui.eval, { desc = "Debugger: Evaluate word" })

    -- Configurations
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      -- port = "8123",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      }
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node",
      }
    }
  end,
}
