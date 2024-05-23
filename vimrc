" :PlugInstall to install plugins
call plug#begin()
" https://github.com/terryma/vim-multiple-cursors/blob/master/doc/multiple_cursors.txt
Plug 'terryma/vim-multiple-cursors'

" https://github.com/tpope/vim-surround/blob/master/doc/surround.txt
Plug 'tpope/vim-surround'

" https://github.com/tommcdo/vim-exchange/blob/master/doc/exchange.txt
Plug 'tommcdo/vim-exchange'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Basics
nnoremap \e :e ~/.vimrc<CR>
nnoremap \r :source ~/.vimrc<CR>
set nocompatible
syntax on set syntax=pearl
set t_Co=256
set mouse=a
set clipboard+=unnamed 
set background=light
filetype plugin indent on
set number
set cursorline
set path+=**
set wildmenu
set wildmode=full
set history=1000
set undolevels=1000
let mapleader=" "
set hidden
set noswapfile
set nobackup
set backspace=2 
set colorcolumn=80
set encoding=utf-8

"no beeping
set vb t_vb= 

"faster buffer navigation
" nnoremap <C-N> :bnext<CR>
" nnoremap <C-P> :bprev<CR>

"easier line navigation
nnoremap <S-H> 0
nnoremap <S-L> $

"Indent settings
set autoindent 
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

"Search settings
set showmatch
set incsearch
set hlsearch
set ignorecase
nmap <silent> <BS>  :nohlsearch<CR>
" // to search for highlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

