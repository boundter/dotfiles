vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 3
vim.opt.colorcolumn = "100"

vim.api.nvim_create_autocmd("BufWritePre", {
   callback = function()
      vim.lsp.buf.format()
   end,
})
