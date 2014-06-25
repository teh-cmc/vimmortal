""" Vimmortal 2k14 gros!

syntax on
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
filetype plugin on
filetype plugin indent on

colorscheme twilight256

" space saves everything
nmap <space> :wa!<cr>

" ctrl+c foces quit
nmap <C-c> :qa!<cr>
imap <C-c> <esc>:qa!<cr>
vmap <C-c> <esc>:qa!<cr>

" ctrl+z saves and closes current file
nmap <C-z> :wq!<cr>
imap <C-z> <esc>:wq!<cr>
vmap <C-z> <esc>:wq!<cr>
" shift+z saves and closes current file
nmap <S-z> :wqa!<cr>
vmap <S-z> <esc>:wqa!<cr>

" ctrl+t opens a new tab (in nerdtree)
nmap <C-t> :tabnew .<cr>
imap <C-t> <esc>:tabnew .<cr>
vmap <C-t> <esc>:tabnew .<cr>

" tl -> tabnext
nmap tl :tabnext<cr>
" th -> tabprevious
nmap th :tabprevious<cr>

" ctrl+j (un)toggles comment
nmap <C-j> <plug>NERDCommenterToggle
vmap <C-j> <plug>NERDCommenterToggle

" I don't even remember tbh
" imap <S-Char-58> <nop>

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
set clipboard+=autoselect
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
set matchtime=3
set nostartofline
set numberwidth=4
set report=0
set ruler
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v][vimmortal!]
set tabpagemax=99

" tab stuff
set tabstop=4
set expandtab
set shiftwidth=4
set listchars=tab:›-,trail:•,extends:#,nbsp:.

autocmd FileType go set expandtab

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('$HOME/.vim/bundle'))

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
NeoBundle 'fatih/vim-go'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdcommenter'

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

