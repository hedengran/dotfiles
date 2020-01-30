"ALWAYS PUT A .vimrc FILE WITH COMMAND --- runtime vimrc

    "define filetype pddl to lisp for syntax highlight
au BufRead,BufNewFile *.pddl set filetype=lisp

"Basics
set nocompatible
syntax on set syntax=pearl
set t_Co=256
set mouse=a
set clipboard+=unnamed
set background=light
colorscheme paperwhite
filetype plugin indent on
set number
set relativenumber
set cursorline
set path+=**
set wildmenu
set wildmode=full
set history=1000
set undolevels=1000
let mapleader=","
set hidden
set noswapfile
set nobackup
set backspace=2 
set colorcolumn=80
set encoding=utf-8

"fat fingers
:command W w
:command Q q
:command WQ wq
:command Wq wq

"no beeping
set vb t_vb= 

"insert current time with F5
nnoremap <F5> "=strftime("%c")>CR>P

"faster buffer navigation
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

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

"--------------------Vundle begin settings
"Vundle bootstrap
if !filereadable($HOME . '/.vim/bundle/vundle/.git/config') && confirm("Clone Vundle?","Y\nn") == 1
    exec '!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/vundle/'
endif

filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'tpope/vim-fugitive'
Plugin 'ap/vim-buftabline'
Plugin 'junegunn/goyo.vim'
call vundle#end()
filetype plugin indent on
"--------------------Vundle end settings

func! WordProcessorMode() 
    setlocal formatoptions=1 
    setlocal noexpandtab 
    setlocal spell spelllang=en_us 
    set complete+=s
    setlocal wrap 
    setlocal linebreak 

    "wrap markdown headlines
endfu 
com! WP call WordProcessorMode()
