return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- lazy-load on first buffer
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config.lsp")
   end,
}
