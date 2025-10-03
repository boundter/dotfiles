return {
   -- Visual
   require("config.solarized_osaka"),
   require("config.catppuccin"),
   require("config.indent_blankline"),
   require("config.lualine"),
   require("config.notify"),
   -- Editor
   require("config.undotree"),
   -- Git
   require("config.fugitive"),
   require("config.gitsigns"),
   -- File handling
   require("config.nvimtree"),
   require("config.telescope"),
   require("config.harpoon"),
   -- LSP
   require("config.neodev_plugin"),
   require("config.treesitter"),
   require("config.mason_plugin"),
   require("config.mason_lspconfig"),
   require("config.cmp"),
   require("config.rustaceanvim"),
   require("config.dap"),
   require("config.nvim_metals"),
   require("config.copilot_lsp"),
   require("config.dap_python"),
   -- Utilities
   require("config.markdown_preview"),
   -- {
   --    "olimorris/codecompanion.nvim",
   --    opts = {},
   --    dependencies = {
   --       "nvim-lua/plenary.nvim",
   --       "nvim-treesitter/nvim-treesitter"
   --    }
   -- }
}
