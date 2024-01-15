return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "help" },
      sync_intall = false,
      auto_install = true,
      highlight = {
         enable = true,
         additional_vim_regex_highlighting = false
      },
      config = true,
      main = "nvim-treesitter.configs"
   }
}
