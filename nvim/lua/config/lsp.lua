local lspconfig = require("lspconfig")
local buf_keymap = vim.api.nvim_buf_set_keymap
local cmd = vim.cmd

local client_capabilities = require('cmp_nvim_lsp').default_capabilities()
client_capabilities.offsetEncoding = { 'utf-16' }

local keymap_opts = { noremap = true, silent = true }
local function setup_keymaps(client, _bufnr)
  buf_keymap(0, 'n', 'gD', '', vim.tbl_extend('keep', { callback = vim.lsp.buf.declaration }, keymap_opts))
  buf_keymap(0, 'n', 'gd', '<cmd>Glance definitions<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gi', '<cmd>Glance implementations<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gS', '', vim.tbl_extend('keep', { callback = vim.lsp.buf.signature_help }, keymap_opts))
  buf_keymap(0, 'n', 'gTD', '', vim.tbl_extend('keep', { callback = vim.lsp.buf.type_definition }, keymap_opts))
  buf_keymap(0, 'n', '<leader>rn', '', {
    callback = function()
      return ':IncRename ' .. vim.fn.expand '<cword>'
    end,
    expr = true,
  })
  buf_keymap(0, 'v', '<leader>rn', '', {
    callback = function()
      return ':IncRename ' .. vim.fn.expand '<cword>'
    end,
    expr = true,
  })
  buf_keymap(0, 'n', 'gr', '<cmd>Glance references<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gA', '', vim.tbl_extend('keep', { callback = vim.lsp.buf.code_action }, keymap_opts))
  buf_keymap(0, 'v', 'gA', '', vim.tbl_extend('keep', { callback = vim.lsp.buf.range_code_action }, keymap_opts))

  -- TODO: Use the nicer new API for autocommands
  cmd 'augroup lsp_aucmds'
  if client.server_capabilities.documentHighlightProvider then
    cmd 'au CursorHold <buffer> lua vim.lsp.buf.document_highlight()'
    cmd 'au CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
  end
  cmd 'augroup END'
end

local on_attach_fns = {
  function(client, bufnr)
    vim.lsp.inlay_hint.enable(
      bufnr,
      client.server_capabilities.inlayHintProvider ~= nil and client.server_capabilities.inlayHintProvider ~= false
    )
  end,
  setup_keymaps,
}

local function do_on_attach_fns(client, bufnr)
  for _, fn in ipairs(on_attach_fns) do
    fn(client, bufnr)
  end
end

local servers = {
  lua_ls = {
    before_init = require('neodev.lsp').before_init,
    single_file_support = true,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
        completion = {
          workspaceWord = true,
          callSnippet = 'Both',
        },
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        telemetry = { enable = false },
      },
      diagnostics = {
        groupSeverity = {
          strong = 'Warning',
          strict = 'Warning',
        },
        groupFileStatus = {
          ['ambiguity'] = 'Opened',
          ['await'] = 'Opened',
          ['codestyle'] = 'None',
          ['duplicate'] = 'Opened',
          ['global'] = 'Opened',
          ['luadoc'] = 'Opened',
          ['redefined'] = 'Opened',
          ['strict'] = 'Opened',
          ['strong'] = 'Opened',
          ['type-check'] = 'Opened',
          ['unbalanced'] = 'Opened',
          ['unused'] = 'Opened',
        },
        unusedLocalExclude = { '_*' },
      },
      format = {
        enable = false,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          continuation_indent_size = '2',
        },
      },
    },
  },
}

for server, config in pairs(servers) do
  -- TODO: maybe refactor to avoid creating a new closure per server
  if config.on_attach then
    local old_on_attach = config.on_attach
    config.on_attach = function(client, bufnr)
      old_on_attach(client, bufnr)
      do_on_attach_fns(client, bufnr)
    end
  else
    config.on_attach = function(client, bufnr)
      do_on_attach_fns(client, bufnr)
    end
  end

  config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {}, client_capabilities)
  lspconfig[server].setup(config)
end
