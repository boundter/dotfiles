local M = {}

M.undotree = {
   {"<leader>u", vim.cmd.UndotreeToggle},
}

local harpoon = require("harpoon")
M.harpoon = {
   { "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
   { "<C-r>",      function() harpoon:list():select(1) end },
   { "<C-t>",      function() harpoon:list():select(2) end },
   { "<C-y>",      function() harpoon:list():select(3) end },
   { "<leader>ha", function() harpoon:list():append() end,                     desc = "Harpoon Add file" },
   { "<leader>hn", function() harpoon:list():next() end,                       desc = "Harpoon Prev" },
   { "<leader>hp", function() harpoon:list():prev() end,                       desc = "Harpoon Next" },
   { "<leader>hs", '<cmd>Telescope harpoon marks<cr>',                         desc = "Harpoon Marks" },
}

M.diagnostics = {
   {"[d", vim.diagnostic.goto_prev},
   {"]d", vim.diagnostic.goto_next},
   {"<leader>dd", vim.diagnostic.open_float},
   {"<leader>dl", vim.diagnostic.setloclist},
}

M.lsp = {
   {"gD",vim.lsp.buf.declaration},
   {"gd", vim.lsp.buf.definition},
   {"K", vim.lsp.buf.hover},
   {"gi", vim.lsp.buf.implementation},
   {"<C-k>", vim.lsp.buf.signature_help},
   {"<space>wa", vim.lsp.buf.add_workspace_folder},
   {"<space>wr", vim.lsp.buf.remove_workspace_folder},
   {"<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end},
    {"<space>D", vim.lsp.buf.type_definition},
    {"<space>rn", vim.lsp.buf.rename},
    {"<space>ca", vim.lsp.buf.code_action},
    {"gr", vim.lsp.buf.references},
    {"<space>f", function()
      vim.lsp.buf.format { async = true }
    end},
}

return M
