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
   { 'folke/neodev.nvim', config = true },
   require("config.treesitter"),
   { "williamboman/mason.nvim", lazy = false, config = true },
   require("config.mason_lspconfig"),
   require("config.cmp"),
   {
      'mrcjkb/rustaceanvim',
      version = '^3', -- Recommended
      ft = { 'rust' },
   },
   {"scalameta/nvim-metals",
   ft = { "scala", "sbt", "java" },
   opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.settings = {
         showImplicitArguments = true,
      }
      metals_config.init_options.statusBarProvider = "on"
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      return metals_config
   end,
   config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
         pattern = self.ft,
         callback = function()
            require("metals").initialize_or_attach(metals_config)
         end,
         group = nvim_metals_group,
      })
   end
   },
}
