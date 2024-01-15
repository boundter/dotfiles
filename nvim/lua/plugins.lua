return {
   -- Visual
   require("config.solarized_osaka"),
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
   require("config.treesitter"),
   { "williamboman/mason.nvim", lazy = false, config = true },
   require("config.mason_lspconfig"),
   require("config.cmp")
}
