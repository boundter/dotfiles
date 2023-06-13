-- Airline
vim.opt.laststatus = 2  -- always show airline
vim.cmd([[set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}]])  -- add fugitive to the airline
vim.cmd([[let g:airline#extensions#bufferline#enabled = 1]])  -- add bufferline to airline
vim.g.airline_theme = 'solarized'
vim.g.airline_solarized_bg = 'light'
