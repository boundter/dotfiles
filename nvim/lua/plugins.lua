return {
   -- Visual
   require("config.solarized_osaka"),
   require("config.catppuccin"),
   require("config.indent_blankline"),
   require("config.lualine"),
   -- Editor
   require("config.undotree"),
   -- Git
   { "tpope/vim-fugitive", keys=require("config.keys").fugitive},
   require("config.gitsigns"),
   -- File handling
   require("config.nvimtree"),
   require("config.telescope"),
   require("config.harpoon"),
   -- LSP
   { 'folke/neodev.nvim', config = true },
   require("config.treesitter"),
   { "williamboman/mason.nvim", lazy = false, config = true },
   require("config.mason_lspconfig"),
   require("config.cmp"),
   require("config.rustaceanvim"),
   { "mfussenegger/nvim-dap-python",
      config = function(self, opts)
         require("dap-python").setup("~/.envs/debugpy/bin/python")
         require("dap-python").test_runner = "pytest"
      end,
      ft = "python" },
   require("config.nvim_metals"),
   { "mfussenegger/nvim-dap", keys=require("config.keys").dap },
   -- Utilities
   require("config.markdown_preview"),
}
