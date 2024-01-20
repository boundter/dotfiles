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
   {"<C-s>", vim.lsp.buf.signature_help},
   {"gr", vim.lsp.buf.references},
   -- {"<leader>wa", vim.lsp.buf.add_workspace_folder},
   -- {"<leader>wr", vim.lsp.buf.remove_workspace_folder},
   {"<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end},
   {"<leader>cd", vim.lsp.buf.type_definition},
   {"<leader>cn", vim.lsp.buf.rename},
   {"<leader>ca", vim.lsp.buf.code_action},
   {"<leader>f", function()
      vim.lsp.buf.format { async = true }
   end},
}

local luasnip = require("luasnip")
local cmp = require("cmp")
M.cmp = {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
}

return M
