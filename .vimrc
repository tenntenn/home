set nocompatible
filetype off

set rtp+=~/.vim/vundle/
call vundle#rc()

Bundle 'Lokaltog/vim-powerline'
Bundle 'JavaScript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'IndentAnything'

filetype plugin indent on

set tabstop=4
set expandtab
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.js set ft=javascript fenc=utf-8
syntax on
set nu
set guifont=Inconsolata_for_Powerline:h11:cANSI
let g:Powerline_symbols='fancy'
