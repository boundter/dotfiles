call plug#begin()

"Plug 'matze/vim-tex-fold'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-obsession'

call plug#end()

" colorscheme
set background=dark
colorscheme solarized
" let g:solarized_termcolors=256
highlight ColorColumn ctermbg=lightgrey

" editor
set encoding=utf-8  
filetype on         " detect filetype
syntax enable				" syntax-highlighting
set nu							" numbering lines
set tabstop=2				" tabstop = 2 spaces
set softtabstop=2		" softtabstop = 2 spaces
set shiftwidth=2		" indent = 2 spaces
set expandtab     	" expands tab to spaces 
set textwidth=80		" linebreak after x characters
set showmatch				" Show matching braces
set hlsearch				" Highlight search results
set colorcolumn=80 	"colorcolumn at the x-th row
set mouse=a 				" activate mouse
set backspace=indent,eol,start " ?
set nocompatible    " ?         
set hidden 					" switch between unsaved buffers

" .vimrc
set exrc				"use local .vimrc
set secure			"secure local .vimrc

" move .swp files in their own directory
set backupdir=~/.backup//,.,/tmp//
set directory=~/.backup//,.,/tmp//

" airline
set laststatus=2 " always show airline
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " add fugitive to the airline
let g:airline#extensions#bufferline#enabled = 1 " add bufferline to airline

" txt-files
autocmd FileType text set tw=79
autocmd FileType text set syntax=txt

" shortcuts
noremap <silent> <C-S> :update<CR>
