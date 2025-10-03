return {
   "olimorris/codecompanion.nvim",
   opts = {},
   keys =     function()
      return require("config.keys").codecompanion
   end,
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
}
