return {
   "ThePrimeagen/harpoon",
   branch = "harpoon2",
   dependencies = { "nvim-lua/plenary.nvim" },
   keys = function()
      return require("config.keys").harpoon
   end,
   config  = true
}
