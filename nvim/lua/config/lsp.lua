local lspconfig = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup{
   capabilities = capabilities
}

lspconfig.pyright.setup{
   capabilities = capabilities
}

lspconfig.ruff_lsp.setup{
   capabilities = capabilities
}

lspconfig.marksman.setup{
   capabilities = capabilities
}

lspconfig.bashls.setup{
   capabilities = capabilities
}

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
