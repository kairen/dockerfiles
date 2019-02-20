set encoding=utf-8
set nocompatible
set number
set cursorline
set shiftwidth=4
set backspace=indent,eol,start
set completeopt=longest,menu
set tabstop=4
set softtabstop=4
set updatetime=100
set autowrite
filetype off
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'c9s/helper.vim'
Plugin 'c9s/treemenu.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'c9s/hypergit.vim'
Plugin 'c9s/vikube.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'kairen/onedark.vim'

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

call vundle#end()            " required
filetype plugin indent on    " required

"colorscheme onedark
let g:onedark_termcolors=256
set term=xterm-256color

if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

if !has('gui_running')
  set t_Co=256
endif