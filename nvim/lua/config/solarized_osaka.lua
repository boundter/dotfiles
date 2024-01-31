return {
   "craftzdog/solarized-osaka.nvim",
   enabled = false,
   lazy = false,
   priority = 1000,
   opts = {
      on_colors = function(colors)
         colors.Normal = colors.orange
      end,
      on_highlights = function(highlights, colors)
         highlights["MsgArea"] = {fg = colors.base}
      end,
   },
   config = true,
   cmd = function()
      vim.cmd("colorscheme solarized-osaka")
   end,
}
