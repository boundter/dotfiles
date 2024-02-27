return {
   -- Visual
   require("config.solarized_osaka"),
   require("config.catppuccin"),
   require("config.indent_blankline"),
   require("config.lualine"),
   -- Editor
   require("config.undotree"),
   -- Git
   { "tpope/vim-fugitive" },
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
   require("config.nvim_metals"),
   { "mfussenegger/nvim-dap", keys=require("config.keys").dap },
   -- Utilities
   require("config.markdown_preview"),
}
