local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  -- Appearence
  {'shaunsingh/solarized.nvim', options = {theme = 'solarized'}},
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  'bling/vim-bufferline',
  -- Version Control
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',
  -- Naviagtion
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    }
  },
  -- Languages
	{
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    }
  },
  {'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", }}
})

-- ==========
-- Remaps
-- ==========

-- Make Life painful
vim.keymap.set('', '<Up>', '<Nop>', {})
vim.keymap.set('', '<Down>', '<Nop>', {})
vim.keymap.set('', '<Left>', '<Nop>', {})
vim.keymap.set('', '<Right>', '<Nop>', {})

-- Split Naviagation
vim.keymap.set('', '<C-J>', '<C-W><C-J>', {noremap = True})
vim.keymap.set('', '<C-K>', '<C-W><C-K>', {noremap = True})
vim.keymap.set('', '<C-L>', '<C-W><C-L>', {noremap = True})
vim.keymap.set('', '<C-H>', '<C-W><C-H>', {noremap = True})

-- Vertical movement treats wrapped lines as lines
vim.keymap.set('', 'j', 'gj', {noremap = True})
vim.keymap.set('', 'k', 'gk', {noremap=True})

-- ==========
-- Editor
-- ==========

vim.opt.encoding = 'utf-8'
vim.opt.filetype = 'on'         -- detect filetype
vim.opt.syntax = 'enable'       -- syntax-highlighting
vim.opt.nu = true               -- line numbering
vim.opt.expandtab = true        -- expands tabs to spaces
vim.opt.showmatch = true        -- show matching braces
vim.opt.hlsearch = true         -- highlight search results
vim.opt.colorcolumn = '80,121'  -- colored columns
vim.opt.hidden = true           -- switch between unsaved buffers
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Central location for swap files
-- vim.opt.backupdir = '~/.local/share/nvim_backup/,.,/tmp//'
-- vim.opt.directory = '~/.local/share/nvim_backup//,.,/tmp//'
-- Somehow the options are not working
vim.cmd([[
  set backupdir=$HOME/.backup//,.,/tmp//
  set directory=$HOME/.backup//,.,/tmp//
]])

-- Colors
vim.opt.background = 'light'
require('solarized').set()
vim.cmd([[highlight! link SignColumn LineNr]])

-- Airline
vim.opt.laststatus = 2  -- always show airline
vim.cmd([[set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}]])  -- add fugitive to the airline
vim.cmd([[let g:airline#extensions#bufferline#enabled = 1]])  -- add bufferline to airline
vim.g.airline_theme = 'solarized'
vim.g.airline_solarized_bg = 'light'


local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- LSP mappings
map("n", "gD",  vim.lsp.buf.definition)
map("n", "K",  vim.lsp.buf.hover)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gr", vim.lsp.buf.references)
map("n", "gds", vim.lsp.buf.document_symbol)
map("n", "gws", vim.lsp.buf.workspace_symbol)
map("n", "<leader>cl", vim.lsp.codelens.run)
map("n", "<leader>sh", vim.lsp.buf.signature_help)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", "<leader>ws", function()
  require("metals").hover_worksheet()
end)

-- all workspace diagnostics
map("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
map("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
map("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
map("n", "<leader>d", vim.diagnostic.setloclist)

map("n", "[c", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

map("n", "]c", function()
  vim.diagnostic.goto_next({ wrap = false })
end)

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
map("n", "<leader>dc", function()
  require("dap").continue()
end)

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end)

map("n", "<leader>dK", function()
  require("dap.ui.widgets").hover()
end)

map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end)

map("n", "<leader>dso", function()
  require("dap").step_over()
end)

map("n", "<leader>dsi", function()
  require("dap").step_into()
end)

map("n", "<leader>dl", function()
  require("dap").run_last()
end)

-- completion related settings
-- This is similiar to what I use
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion but this is just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
