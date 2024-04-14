-- Directory navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window movement
vim.keymap.set("n", "<c-h>", "<c-w>h", {})
vim.keymap.set("n", "<c-j>", "<c-w>j", {})
vim.keymap.set("n", "<c-k>", "<c-w>k", {})
vim.keymap.set("n", "<c-l>", "<c-w>l", {})

-- Line numbers
vim.keymap.set("n", "<leader>nn", "<cmd> set nu! <CR>", {})
vim.keymap.set("n", "<leader>nr", "<cmd> set rnu! <CR>", {})

-- Center on Cursor after moving up or down
vim.keymap.set("n", "<c-d>", "<c-d>zz", {})
vim.keymap.set("n", "<c-u>", "<c-u>zz", {})
