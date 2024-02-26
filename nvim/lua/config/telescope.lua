return {
   {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.5",
      dependencies = {"nvim-lua/plenary.nvim"},
      init = require("config.keys").telescope,
      opts = {
         defaults = {
            layout_strategy = "horizontal"
         }
      },
      config = true
   }
}
