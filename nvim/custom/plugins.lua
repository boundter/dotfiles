local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      }
    }
  },
  {
      "mrcjkb/rustaceanvim",
      version = '^3', -- Recommended
      ft = { 'rust' },
  }
}
return plugins
