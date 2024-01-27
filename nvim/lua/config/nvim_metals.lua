return {
   "scalameta/nvim-metals",
   ft = { "scala", "sbt", "java" },
   opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.settings = {
         showImplicitArguments = true,
         serverProperties = {"-Xmx4G"},
      }
      -- metals_config.init_options.statusBarProvider = "on"
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
}