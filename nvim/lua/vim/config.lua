vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

vim.opt.encoding = 'utf-8'
vim.opt.filetype = 'on'         -- detect filetype
vim.opt.syntax = 'enable'       -- syntax-highlighting
vim.opt.nu = true               -- line numbering
vim.opt.expandtab = true        -- expands tabs to spaces
vim.opt.showmatch = true        -- show matching braces
vim.opt.hlsearch = true         -- highlight search results
vim.opt.colorcolumn = '80,121'  -- colored columns
vim.opt.hidden = true           -- switch between unsaved buffers
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Central location for swap files
-- vim.opt.backupdir = '~/.local/share/nvim_backup/,.,/tmp//'
-- vim.opt.directory = '~/.local/share/nvim_backup//,.,/tmp//'
-- Somehow the options are not working
vim.cmd([[
  set backupdir=$HOME/.backup//,.,/tmp//
  set directory=$HOME/.backup//,.,/tmp//
]])

-- Colors
vim.opt.background = 'light'
require('solarized').set()
vim.cmd([[highlight! link SignColumn LineNr]])
