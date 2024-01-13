-- Leader/local leader - lazy.nvim needs these set first
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print(vim.fn.stdpath("data"))
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end

vim.loader.enable()
vim.opt.runtimepath:prepend(lazypath)


require("lazy").setup("plugins", opts)

require("config.keymaps")
require("config.options")
