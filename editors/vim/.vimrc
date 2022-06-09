set number                        " Show line number   
set relativenumber                " Show relative number line 
set cursorline                    " Show line above the current line
set hlsearch                      " Highlighting seach pattern matches

syntax on                         " To make sure that the syntax is highlighted in every system

set tabstop=4

colorscheme slate

" Define which color scheme is used basef upon the VIM mode
"if has('gui_running')
"	set background=dark
"	colorscheme solarized
"endif

" File browsing: ignore a list of files 
"let NERDTreeIgnore=['\.pyc$', '\.~$']       " ignore .pyc files

set hlsearch                      " Highlighting searched tearms

set nocompatible              " be iMproved, required, required from vimwiki
filetype off                  " required
filetype plugin on            " required from vimwiki
syntax on                     " required from vimwiki

set encoding=utf-8

" Enable folding
set foldmethod=indent
set foldlevel=99

" ======= "
" SECTION : text editing and motions
" ======= "

" Make vim remember last cursor position in a file
if has("autocmd")
		augroup RememberCursorPosition
				au!
				au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END
endif

" Remaps to move between splitted screens
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Enable folding with the spacebar
nnoremap <space> za

" ========================================================================== "
"                               VUNDLE
" ========================================================================== "
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'rust-lang/rust.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'

call vundle#end()            " required
filetype plugin indent on    " required
" ========================================================================== "

" LIGHTLINE
" =========
"call dein#add('itchyny/lightline.vim')
if !has('gui_running')
  set t_Co=256
endif
set laststatus=2

" NERDTREE
" ========
" Start NEDRTree when Vim is started without file arguments
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Show hidden files
let NERDTreeShowHidden=1
" Remaps
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>m :NERDTreeToggle<CR>

set modifiable               " In order to be able to create files and directories

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
let NERDTreeRespectWildIgnore=1  " Nerdtree config for wildignore

" FZF
" ===
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" SYNTASTIC
" =========
let g:syntastic_python_checkers=['mypy']  " for using mypy for lynting
set statusline+=%#warningmsg#
" Recommended settings
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

