return {
   require("config.telescope"),
   require("config.solarized_osaka"),
   require("config.treesitter"),
   { "williamboman/mason.nvim", lazy = false, config = true },
   require("config.mason_lspconfig"),
   require("config.harpoon"),
   require("config.undotree"),
   require("config.nvimtree"),
   { "tpope/vim-fugitive" },
   require("config.lualine"),
   require("config.indent_blankline"),
   require("config.gitsigns"),
   { 'folke/neodev.nvim', opts = { lspconfig = false } },
   require("config.cmp")
}
