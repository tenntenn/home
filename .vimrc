set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

"" My Bundles here:
""
"" original repos on github
Bundle 'fholgado/minibufexpl.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/syntastic'

set tabstop=4
set expandtab
autocmd BufRead,BufNewFile *.go setfiletype go
syntax on
set nu
