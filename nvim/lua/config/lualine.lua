return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons", "WhoIsSethDaniel/lualine-lsp-progress.nvim" },
   opts = function()
      local osaka = require("lualine.themes.solarized-osaka")
      local colors = require("solarized-osaka.colors")

      osaka.normal.b.bg = colors.default.base01
      return {
         options = {theme = osaka},
         sections = { lualine_c = { "lsp_progress" } }
      }
   end,
   config = true
}
