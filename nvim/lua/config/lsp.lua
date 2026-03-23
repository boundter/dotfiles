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

local dap = require("dap")
dap.listeners.before['event_progressStart']['progress-notifications'] = function(session, body)
 local notif_data = get_notif_data("dap", body.progressId)

 local message = format_message(body.message, body.percentage)
 notif_data.notification = vim.notify(message, "info", {
   title = format_title(body.title, session.config.type),
   icon = spinner_frames[1],
   timeout = false,
   hide_from_history = false,
 })

 notif_data.notification.spinner = 1,
 update_spinner("dap", body.progressId)
end

local dap_virtual_text = require("nvim-dap-virtual-text")
dap_virtual_text.setup()

local ui = require("dapui")

ui.setup()
dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end

dap.listeners.before['event_progressUpdate']['progress-notifications'] = function(session, body)
 local notif_data = get_notif_data("dap", body.progressId)
 notif_data.notification = vim.notify(format_message(body.message, body.percentage), "info", {
   replace = notif_data.notification,
   hide_from_history = false,
 })
end

dap.listeners.before['event_progressEnd']['progress-notifications'] = function(session, body)
 local notif_data = client_notifs["dap"][body.progressId]
 notif_data.notification = vim.notify(body.message and format_message(body.message) or "Complete", "info", {
    icon = "",
    replace = notif_data.notification,
    timeout = 3000
 })
 notif_data.spinner = nil
end
