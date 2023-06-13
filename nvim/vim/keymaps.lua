-- Make Life painful
vim.keymap.set('', '<Up>', '<Nop>', {})
vim.keymap.set('', '<Down>', '<Nop>', {})
vim.keymap.set('', '<Left>', '<Nop>', {})
vim.keymap.set('', '<Right>', '<Nop>', {})

-- Split Naviagation
vim.keymap.set('', '<C-J>', '<C-W><C-J>', {noremap = True})
vim.keymap.set('', '<C-K>', '<C-W><C-K>', {noremap = True})
vim.keymap.set('', '<C-L>', '<C-W><C-L>', {noremap = True})
vim.keymap.set('', '<C-H>', '<C-W><C-H>', {noremap = True})

-- Vertical movement treats wrapped lines as lines
vim.keymap.set('', 'j', 'gj', {noremap = True})
vim.keymap.set('', 'k', 'gk', {noremap=True})

-- LSP mappings
vim.keymap.set("n", "gD",  vim.lsp.buf.definition)
vim.keymap.set("n", "K",  vim.lsp.buf.hover)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- all workspace diagnostics
vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
vim.keymap.set("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
vim.keymap.set("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)

vim.keymap.set("n", "[c", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

vim.keymap.set("n", "]c", function()
  vim.diagnostic.goto_next({ wrap = false })
end)
