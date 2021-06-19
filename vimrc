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
Plug 'rhysd/vim-grammarous'
Plug 'Valloric/YouCompleteMe'
Plug 'preservim/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

" make life painful
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" clipboard
set clipboard=unnamed

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
highlight! link SignColumn LineNr

" .vimrc
set exrc				"use local .vimrc
set secure			"secure local .vimrc

" move .swp files in their own directory
set backupdir=$HOME/.backup//,.,/tmp//
set directory=$HOME/.backup//,.,/tmp//

" airline
set laststatus=2 " always show airline
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " add fugitive to the airline
let g:airline#extensions#bufferline#enabled = 1 " add bufferline to airline

" txt-files
autocmd FileType text setlocal tw=79
autocmd FileType text setlocal syntax=txt

" python prevent linebreak
autocmd FileType python setlocal formatoptions=croql
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4

" text prevent linebreak
autocmd FileType text setlocal formatoptions=croql

" html prevent linebreak
autocmd FileType html setlocal formatoptions=croql

" sh prevent linebreak
autocmd FileType sh setlocal formatoptions=croql

" shortcuts
noremap <silent> <C-S> :update<CR>

" remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

" tab-complete like bash
set wildmode=list:longest,full
set wildmenu

" useful aliases
cabbrev sc setlocal spell spelllang=en_us

" python linters
let g:sytastic_python_checkers = ['flake8', 'pylint']

" black on save
"autocmd BufWritePre *.py execute ':Black'
