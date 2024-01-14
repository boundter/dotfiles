return {
   {
      "nvim-telescope/telescope.nvim", 
      tag = "0.1.5", 
      dependencies = {"nvim-lua/plenary.nvim"},  
      init = function()
         require "config.telescope_config"
      end,
      opts = require("config.telescope_setup"),
      config = true
   },
   {
      "craftzdog/solarized-osaka.nvim",
      lazy = false,
      priority = 1000,
      cmd = function()
         vim.cmd("colorscheme solarized-osaka")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = require("config.treesitter_setup"),
      config = true,
      main = "nvim-treesitter.configs"
   },
   {
      "williamboman/mason.nvim", 
      lazy = false,
      config = true
   },
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {"neovim/nvim-lspconfig"},
      opts = require("config.mason_lspconfig_setup"),
      config = true
   },
   {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = function()
         local harpoon = require("harpoon")
         return {
            { "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
            { "<C-h>",      function() harpoon:list():select(1) end },
            { "<C-t>",      function() harpoon:list():select(2) end },
            { "<C-s>",      function() harpoon:list():select(3) end },
            { "<leader>ha", function() harpoon:list():append() end,                     desc = "Harpoon Add file" },
            { "<leader>hp", function() harpoon:list():next() end,                       desc = "Harpoon Prev" },
            { "<leader>hn", function() harpoon:list():prev() end,                       desc = "Harpoon Next" },
            { "<leader>hm", '<cmd>Telescope harpoon marks<cr>',                         desc = "Harpoon Marks" },
         }
      end,
      config  = true
   },
   {
      "mbbill/undotree",
      keys = function()
         return {
            {"<leader>u", vim.cmd.UndotreeToggle},
         }
      end,
   },
   {
      "tpope/vim-fugitive",

   }, 
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys =     function()
			return {
				{"<C-n>", "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
				-- focus
				{"<leader>e",  "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
			}
		end,
		opts = function()
			return require("config.nvimtree")
		end,
		config = true
	},
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = true
   },
   { 
      "lukas-reineke/indent-blankline.nvim", 
      main = "ibl", 
      config = true
   },
   {
      "lewis6991/gitsigns.nvim",
      ft = { "gitcommit", "diff" },
      init = function()
         -- load gitsigns only when a git file is opened, from NvChad
         vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
               vim.fn.jobstart({"git", "-C", vim.loop.cwd(), "rev-parse"},
               {
                  on_exit = function(_, return_code)
                     if return_code == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                           require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                     end
                  end
               }
               )
            end,
         })
      end,
      config = true
   },
}
