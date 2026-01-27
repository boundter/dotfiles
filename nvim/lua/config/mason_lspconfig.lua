return {
   "williamboman/mason-lspconfig.nvim",
   dependencies = {"neovim/nvim-lspconfig"},
   opts = {
      ensure_installed = {"lua_ls", "rust_analyser", "pyright", "ruff", "marksman", "bashls", "yamlls", "harper_ls"},
      automatic_enable = {
        exclude = {
            "rust_analyzer",
        }
      }
   },
   config = true
}
