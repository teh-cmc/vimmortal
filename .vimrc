syntax on
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
filetype plugin on
filetype plugin indent on

colorscheme twilight256

nmap <space> :wa!<cr>
nmap <C-c> :qa!<cr>
imap <C-c> <esc>:qa!<cr>
vmap <C-c> <esc>:qa!<cr>
nmap <C-z> :wq!<cr>
imap <C-z> <esc>:wq!<cr>
vmap <C-z> <esc>:wq!<cr>
nmap <S-z> :wqa!<cr>
vmap <S-z> <esc>:wqa!<cr>
imap <S-Char-58> <nop>
nmap <C-l> :e .<cr>
imap <C-l> <esc>:e .<cr>
vmap <C-l> <esc>:e .<cr>

set nocompatible
set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a
set number
set autoindent
set smartindent
set autochdir
set backspace=indent,eol,start
set clipboard+=unnamed
set noerrorbells
set wildmenu
set hlsearch
set wildmode=list:longest
set cursorline
set cursorcolumn
set laststatus=2
set lazyredraw
set linespace=0
set list
set number
set matchtime=3
set nostartofline
set numberwidth=4
set report=0
set ruler
set listchars=tab:>-,trail:-
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v][vimmortal!]
set tabstop=4
set tabpagemax=99


"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=/home/cmc/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/cmc/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jimenezrick/vimerl'
NeoBundle 'Valloric/YouCompleteMe'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


"  :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

