local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "lua_ls",
  "pyright",
  "ruff",
  "marksman",
  "bashls",
  "yamlls",
  "groovyls",
  "gitlab_ci_ls",
}

for _, server in ipairs(servers) do
   vim.lsp.config(server, {
      capabilities = capabilities
      }
   )
   vim.lsp.enable(server)
end

vim.lsp.config("harper_ls", {
      filetypes = { "markdown", "gitcommit", "text" },
      capabilities = capabilities,
      settings = {
         ["harper-ls"] = {
            linters = {
               SpellCheck = false,
               AvoidCurses = false
            }
         }
      }
   }
)
vim.lsp.enable("harper_ls")

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local keymaps = require("config.keys")

for _, key in ipairs(keymaps.diagnostics) do
   vim.keymap.set("n", key[1], key[2])
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    for _, key in ipairs(keymaps.lsp) do
      vim.keymap.set("n", key[1], key[2], opts)
    end
  end,
})


local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup {
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert(keymaps.cmp()),
   sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
   },
}
