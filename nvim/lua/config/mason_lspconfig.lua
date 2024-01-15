return {
   "williamboman/mason-lspconfig.nvim",
   dependencies = {"neovim/nvim-lspconfig"},
   opts = {
      ensure_installed = {"lua_ls", "rust_analyzer", "ruff_lsp", "pyright", "pylsp"}
   },
   config = true
}