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
   keys = require("config.keys").dap
}
