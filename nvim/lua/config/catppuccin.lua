return {
   "catppuccin/nvim",
   name = "catppuccin",
   lazy = false,
   priority = 1000,
   opts = {
      flavour = vim.env.NVIM_FLAVOUR or "macchiato",
      auto_integrations = true,
   },
   config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
}
