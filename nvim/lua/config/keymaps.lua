-- Directory navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window movement
vim.keymap.set("n", "<c-h>", "<c-w>h", {})
vim.keymap.set("n", "<c-j>", "<c-w>j", {})
vim.keymap.set("n", "<c-k>", "<c-w>k", {})
vim.keymap.set("n", "<c-l>", "<c-w>l", {})

-- Line numbers
vim.keymap.set("n", "<leader>nn", "<cmd> set nu! <CR>", {})
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", {})
