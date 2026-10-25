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
      filetypes = { "markdown", "gitcommit", "text", "asciidoc" },
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

local function maybe_detach_harper(buf)
  if not vim.bo[buf].spelllang:match("de") then
    return
  end
  for _, client in ipairs(vim.lsp.buf_get_clients(buf)) do
    if client.name == "harper_ls" then
      pcall(vim.lsp.buf_detach_client, buf, client.id)
    end
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "harper_ls" then
      maybe_detach_harper(ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "spelllang",
  callback = function(ev)
    maybe_detach_harper(ev.buf)
  end,
})

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
