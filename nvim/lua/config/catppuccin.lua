return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
   cmd = function()
      vim.cmd("colorscheme catppuccin-macchiato")
   end,
}
