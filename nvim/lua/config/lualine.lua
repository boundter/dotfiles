return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons"},
   opts = function()
      -- local osaka = require("lualine.themes.solarized-osaka")
      -- local colors = require("solarized-osaka.colors")

      -- osaka.normal.b.bg = colors.default.base01
      return {
         options = {theme = "auto"},
         sections = { lualine_c = {'lsp_status'} }
      }
   end,
   config = true
}
