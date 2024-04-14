vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.colorcolumn = "120"

vim.api.nvim_create_autocmd("BufWritePre", {
   pattern = {"*.scala"},
   callback = function()
      vim.lsp.buf.format()
   end,
})
