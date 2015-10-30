
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'flazz/vim-colorschemes'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
call vundle#end()

filetype plugin indent on
"Ok. Done.

set backspace=indent,eol,start
set number
set nowrap
set hidden
set encoding=utf-8
set clipboard=unnamed
"set editing-mode vi

inoremap jk <ESC>

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" we also want to get rid of accidental trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" Flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" =================================================
" -----------
" Color setup
" -----------
set t_Co=256
syntax enable
set background=dark

try
  colorscheme Zenburn
catch E185
endtry

" =================================================
" -------
" Airline
" -------
" Allows the bottom status line for airline to be shown
set laststatus=2
let g:airline_powerline_fonts=1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" =================================================
" -------------
" YouCompleteMe
" -------------
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


let python_highlight_all=1


let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree"
