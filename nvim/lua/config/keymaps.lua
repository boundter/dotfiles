-- Directory navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window movement
vim.keymap.set("n", "<c-h>", "<c-w>h", silent)
vim.keymap.set("n", "<c-j>", "<c-w>j", silent)
vim.keymap.set("n", "<c-k>", "<c-w>k", silent)
vim.keymap.set("n", "<c-l>", "<c-w>l", silent)

-- Line numbers
vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>", silent)
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", silent)
