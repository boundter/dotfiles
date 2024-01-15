return {
   "ThePrimeagen/harpoon",
   branch = "harpoon2",
   dependencies = { "nvim-lua/plenary.nvim" },
   keys = function()
      local harpoon = require("harpoon")
      return {
         { "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
         { "<C-h>",      function() harpoon:list():select(1) end },
         { "<C-t>",      function() harpoon:list():select(2) end },
         { "<C-s>",      function() harpoon:list():select(3) end },
         { "<leader>ha", function() harpoon:list():append() end,                     desc = "Harpoon Add file" },
         { "<leader>hn", function() harpoon:list():next() end,                       desc = "Harpoon Prev" },
         { "<leader>hp", function() harpoon:list():prev() end,                       desc = "Harpoon Next" },
         { "<leader>hs", '<cmd>Telescope harpoon marks<cr>',                         desc = "Harpoon Marks" },
      }
   end,
   config  = true
}
