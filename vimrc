set nocompatible                  " required
filetype off                      " required

set number                        " Show line number   
set relativenumber                " Show relative number line 

" Folfing
set foldmethod=indent             " Enable folding
set foldlevel=99
nnoremap <space> za               " Enable folding with the spacebar



" =============================================================================
" Set the runtime path to include Vundle and initialize 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'        " Vundle manage Vundle, required
" Add other plugins here 

Plugin 'tmhedberg/SimplyFold'     " To manage the folds
Plugin 'vim-scripts/indentpython.vim'  " To get autoindent in Python
"Bundle 'Valloric/YourCompleteMe'  " Auto-complete for Python 
Plugin 'vim-syntastic/syntastic'   " Syntack checking Python
Plugin 'nvie/vim-flake8'           " PEP 8 checking, obviously Python
Plugin 'jnurmine/Zenburn'                   " Color schemes
Plugin 'altercation/vim-colors-solarized'   " Color schemes
Plugin 'kien/ctrlp.vim'            " Super Searching from vim, press ^Ctrl + P
Plugin 'scrooloose/nerdtree'       " File browsing: NERDTree
Plugin 'jistr/vim-nerdtree-tabs'   " File browsing: to use tabs
Plugin 'tpope/vim-fugitive'        " Git integration 
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}  " Powerline

" End of my plugins
call vundle#end()                 " required
" =============================================================================
filetype plugin indent on         " required

leg g:SimplyFold_docstring_preview=1  " To see the doctrings for the folder code

set encoding=utf-8                " To support UTF-8 

" Python indentation acorging to PEP8 standards
au BufNewFile, BufRead *.py,
			\ set tabstop=4
			\ set softtabstop=4
			\ set shiftwidth=4
			\ set textwidth=79
			\ set expandtab
			\ set autoindent
			\ set fileformat=unix

" Full Stack development 
au BufNewFile, BufRead *.js, *.html, *.css
			\ set tabstop=2
			\ set softtabstop=2
			\ set shiftwidth=2

" Falgging Unnecessary Whitespace 
au BufNewFile, BufRead *.py, *.pyw, *.c, *.h match BadWhitespace /\s\+$/

" Make Python code looks pretty
let python_highlight_all=1
syntax on                         " To make sure that the syntax is highlighted in every system

" Define which color scheme is used basef upon the VIM mode
if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif

call togglebg#map("<F5>")         " In solarized scheme: press F5 to change between dark and light themes

" File browsing: ignore a list of files 
let NERDTreeIgnore=['\.pyc$', '\.~$']       " ignore .pyc files
