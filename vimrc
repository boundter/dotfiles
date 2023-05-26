call plug#begin()

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
Plug 'tmhedberg/SimpylFold'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-scala'
call plug#end()

"==================
" Remaps
"==================

" make life painful
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" make j and k act normally for wrapped lines
nnoremap j gj
nnoremap k gk

" YCM
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"==================
" Editor Settings
"==================

set encoding=utf-8
filetype on         " detect filetype
syntax enable				" syntax-highlighting
set nu							" numbering lines
set tabstop=2				" tabstop = 2 spaces
set softtabstop=2		" softtabstop = 2 spaces
set shiftwidth=2		" indent = 2 spaces
set expandtab     	" expands tab to spaces
set showmatch				" Show matching braces
set hlsearch				" Highlight search results
set colorcolumn=80,111 	"colorcolumn at the x-th row
set mouse=a 				" activate mouse
set backspace=indent,eol,start " ?
set nocompatible    " ?
set hidden 					" switch between unsaved buffers
set clipboard=unnamed

" .vimrc
set exrc				"use local .vimrc
set secure			"secure local .vimrc

" move .swp files in their own directory
set backupdir=$HOME/.backup//,.,/tmp//
set directory=$HOME/.backup//,.,/tmp//

" tab-complete like bash
set wildmode=list:longest,full
set wildmenu

" Enable folding
set foldmethod=indent
set foldlevel=99

"==================
" Colors
"==================

" colorscheme
set background=dark
colorscheme solarized
" let g:solarized_termcolors=256
highlight! link SignColumn LineNr

"==================
" Shortcuts
"==================

" useful aliases
cabbrev sc setlocal spell spelllang=en_us
cabbrev scde setlocal spell spelllang=de_de

"==================
" Autocommands
"==================

" remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

"==================
" Plugins
"==================

" airline
set laststatus=2 " always show airline
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " add fugitive to the airline
let g:airline#extensions#bufferline#enabled = 1 " add bufferline to airline

" simplyFold
let g:SimpylFold_docstring_preview = 1

" ycm
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist = {
  \ 'text': 1,
  \}

" python linters
let g:syntastic_python_checkers = ['flake8']

"==================
" Filetype Specific
"==================

" txt-files
autocmd FileType text setlocal syntax=txt
autocmd FileType text setlocal spell spelllang=en_us

" python
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4

" markdown
autocmd FileType markdown setlocal spell spelllang=en_us

" gitcommit
autocmd FileType gitcommit setlocal spell spelllang=en_us

" scla
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala
