set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-powerline'
Bundle 'JavaScript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'IndentAnything'
Bundle 'mattn/zencoding-vim'
Bundle 'mattn/multi-vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'thinca/vim-quickrun'
Bundle 'jnwhiteh/vim-golang'

filetype plugin indent on

set tabstop=4
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.js set ft=javascript fenc=utf-8
syntax on
set nu
set guifont=Inconsolata_for_Powerline:h11:cANSI
let g:Powerline_symbols='fancy'

let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
