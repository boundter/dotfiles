local misc_aucmds = vim.api.nvim_create_augroup("misc_aucmds", { clear = true })

-- remove trainling spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
   group = misc_aucmds,
   pattern ="*",
   command = [[%s/\s\+$//e]]
})
