vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.colorcolumn = "120"

vim.api.nvim_create_autocmd("BufWritePre", {
   pattern = {"*.py"},
   callback = function()
      vim.lsp.buf.format()
   end,
})

