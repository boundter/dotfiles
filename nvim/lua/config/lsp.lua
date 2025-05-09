local lspconfig = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup{
   capabilities = capabilities
}

lspconfig.pyright.setup{
   capabilities = capabilities
}

lspconfig.ruff.setup{
   capabilities = capabilities
}

lspconfig.marksman.setup{
   capabilities = capabilities
}

lspconfig.bashls.setup{
   capabilities = capabilities
}

lspconfig.yamlls.setup{
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
      -- { name = 'copilot' },
   },
   -- formatting = {
   --  format = lspkind.cmp_format({
   --    mode = "symbol",
   --    max_width = 50,
   --    symbol_map = { Copilot = "",  }
   --  })
  -- }
}

require("copilot").setup({
   suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<C-]>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-[>",
    },
  },
})

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

-- LSP integration
-- Make sure to also have the snippet with the common helper functions in your config!

vim.notify = require("notify")

-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

local function get_notif_data(client_id, token)
 if not client_notifs[client_id] then
   client_notifs[client_id] = {}
 end

 if not client_notifs[client_id][token] then
   client_notifs[client_id][token] = {}
 end

 return client_notifs[client_id][token]
end


local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
 local notif_data = get_notif_data(client_id, token)

 if notif_data.spinner then
   local new_spinner = (notif_data.spinner + 1) % #spinner_frames
   notif_data.spinner = new_spinner

   notif_data.notification = vim.notify(nil, nil, {
     hide_from_history = true,
     icon = spinner_frames[new_spinner],
     replace = notif_data.notification,
   })

   vim.defer_fn(function()
     update_spinner(client_id, token)
   end, 100)
 end
end

local function format_title(title, client_name)
 return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
 return (percentage and percentage .. "%\t" or "") .. (message or "")
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
 local client_id = ctx.client_id

 local val = result.value

 if not val.kind then
   return
 end

 local notif_data = get_notif_data(client_id, result.token)

 if val.kind == "begin" then
   local message = format_message(val.message, val.percentage)

   notif_data.notification = vim.notify(message, "info", {
     title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
     icon = spinner_frames[1],
     timeout = false,
     hide_from_history = false,
   })

   notif_data.spinner = 1
   update_spinner(client_id, result.token)
 elseif val.kind == "report" and notif_data then
   notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
     replace = notif_data.notification,
     hide_from_history = false,
   })
 elseif val.kind == "end" and notif_data then
   notif_data.notification =
     vim.notify(val.message and format_message(val.message) or "Complete", "info", {
       icon = "",
       replace = notif_data.notification,
       timeout = 3000,
     })

   notif_data.spinner = nil
 end
end

-- table from lsp severity to vim severity.
local severity = {
  "error",
  "warn",
  "info",
  "info", -- map both hint and info to info?
}
vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
             vim.notify(method.message, severity[params.type])
end

-- DAP integration
-- Make sure to also have the snippet with the common helper functions in your config!

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
