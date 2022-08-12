
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
colorscheme iceberg


" ESC key replace other key
inoremap <silent> jj <esc>


inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap " ""<Left>
inoremap ' ''<Left>
