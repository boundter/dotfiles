return {
   "mfussenegger/nvim-dap-python",
   config = function(self, opts)
      require("dap-python").setup("~/.envs/debugpy/bin/python")
      require("dap-python").test_runner = "pytest"
   end,
   ft = "python"
}
