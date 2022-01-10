
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/user/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/user/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/home/user/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
 
" charset
set encoding=utf-8
scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

" lightline
set laststatus=2
set t_Co=256
set showmode
set showcmd
set ruler

" basic settings
set autoindent
set number
set incsearch
set cursorline
set hlsearch
set nobackup
set noswapfile
set showmatch
set listchars=tab:>.
set list

set tabstop=4
set shiftwidth=4
set expandtab

syntax enable


" ESC key replace other key
inoremap <silent> jj <esc>


inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap " ""<Left>
inoremap ' ''<Left>
