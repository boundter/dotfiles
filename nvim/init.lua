local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  -- Appearence
  {'shaunsingh/solarized.nvim', options = {theme = 'solarized'}},
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  'bling/vim-bufferline',
  -- Version Control
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',
  -- Naviagtion
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    }
  },
  -- Languages
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    }
  },
  {'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", }}
})

require('vim/keymaps')

require('vim/config')

require('airline/config')

require('cmp/config')

require('dap/config')

require('metals/config')
