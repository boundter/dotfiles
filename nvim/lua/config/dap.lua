return {
   "mfussenegger/nvim-dap",
   dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      {
         "jay-babu/mason-nvim-dap.nvim",
         opts = {
            ensure_installed = { "python" }
         }
      },
      "theHamsta/nvim-dap-virtual-text",
   },
   keys = require("config.keys").dap,
   config = function()
      local dap = require("dap")
      local dap_virtual_text = require("nvim-dap-virtual-text")
      local dapui = require("dapui")

      dap_virtual_text.setup()
      dapui.setup()

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
   end,
}
