local misc_aucmds = vim.api.nvim_create_augroup("misc_aucmds", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
  group = misc_aucmds,
  callback = function()
    require("config.lsp")
  end,
  once = true,
})

-- remove trainling spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
   group = misc_aucmds,
   pattern ="*",
   command = [[%s/\s\+$//e]]
})
