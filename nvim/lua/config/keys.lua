local M = {}

M.undotree = {
   {"<leader>u", vim.cmd.UndotreeToggle},
}

local harpoon = require("harpoon")
M.harpoon = {
   { "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
   { "<C-h>",      function() harpoon:list():select(1) end },
   { "<C-t>",      function() harpoon:list():select(2) end },
   { "<C-s>",      function() harpoon:list():select(3) end },
   { "<leader>ha", function() harpoon:list():append() end,                     desc = "Harpoon Add file" },
   { "<leader>hn", function() harpoon:list():next() end,                       desc = "Harpoon Prev" },
   { "<leader>hp", function() harpoon:list():prev() end,                       desc = "Harpoon Next" },
   { "<leader>hs", '<cmd>Telescope harpoon marks<cr>',                         desc = "Harpoon Marks" },
}

M.nvim_tree = {
   {"<C-n>", "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
   -- focus
   {"<leader>e",  "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
}

return M
