local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
