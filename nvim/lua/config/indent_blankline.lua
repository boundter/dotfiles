return {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   config = true,
   opts = {
      scope = { enabled = false },
   },
   init = function()
      local colors = require("solarized-osaka.colors")
      local IblIndent = string.format("highlight IblIndent guifg=%s blend=nocombine", colors.default.base02)
      vim.cmd(IblIndent)
   end,
}
