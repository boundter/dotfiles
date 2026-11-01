local M = {}

local writing_filetypes = {
   asciidoc = true,
   gitcommit = true,
   markdown = true,
   text = true,
}

-- wvim sets WVIM=1. Everywhere else, spelling and grammar stay enabled.
M.active = vim.env.WVIM == "1"
M.checks_enabled = not M.active

local function is_writing_buffer(buf)
   return writing_filetypes[vim.bo[buf].filetype] == true
end

local function apply_spell()
   for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      vim.wo[win].spell = M.checks_enabled and is_writing_buffer(buf)
   end
end

local function start_harper_for_existing_buffers()
   local config = vim.lsp.config.harper_ls
   if not config then
      return
   end

   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf)
         and vim.tbl_contains(config.filetypes, vim.bo[buf].filetype)
      then
         -- vim.lsp.enable() only starts clients for future FileType events,
         -- so attach buffers that are already open.
         vim.lsp.start(vim.deepcopy(config), {
            bufnr = buf,
            reuse_client = config.reuse_client,
            _root_markers = config.root_markers,
         })
      end
   end
end

local function sync_harper()
   -- config.lsp may not have been loaded yet. It will sync on setup.
   if vim.lsp.config.harper_ls == nil then
      return
   end

   vim.lsp.enable("harper_ls", M.checks_enabled)
   if M.checks_enabled then
      start_harper_for_existing_buffers()
   end
end

function M.setup_harper()
   sync_harper()
end

function M.set_checks_enabled(enabled)
   M.checks_enabled = enabled
   sync_harper()
   apply_spell()
   vim.notify("Writing checks " .. (enabled and "on" or "off"))
end

function M.toggle()
   M.set_checks_enabled(not M.checks_enabled)
end

function M.setup()
   if not M.active then
      return
   end

   vim.api.nvim_create_user_command("WritingChecks", function()
      M.toggle()
   end, { desc = "Toggle spelling and grammar checks for writing" })

   local group = vim.api.nvim_create_augroup("writing_checks", { clear = true })
   vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
      group = group,
      callback = function()
         apply_spell()
      end,
   })

   apply_spell()
end

return M
