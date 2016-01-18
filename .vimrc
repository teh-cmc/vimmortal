""""""""""""""""""""""
""" Vimmortal v2.0 """
""""""""""""""""""""""

set nocompatible
colorscheme twilight256

"""""""
" Vim "
"""""""

"""
" Settings
"""

" Leader key
let mapleader = ','

filetype plugin on
filetype plugin indent on
syntax on

if has('clipboard')
    " When possible use + register for copy-paste
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else
        " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Persitent undo settings
if has('persistent_undo')
    set undofile
    " Maximum number of changes that can be undone
    set undolevels=1000
    " Maximum number lines to save for undo on a buffer reload
    set undoreload=10000
endif

scriptencoding utf-8
" Abbrev. of messages (avoids 'hit enter')
set shortmess+=filmnrxoOtT
" Better Unix / Windows compatibility
set viewoptions=folds,options,cursor,unix,slash
" Allow for cursor beyond last character
set virtualedit=onemore
" Store a ton of history (default is 20)
set history=1000
" Allow buffer switching without saving
set hidden
" '.' is an end of word designator
set iskeyword-=.
" '#' is an end of word designator
set iskeyword-=#
" '-' is an end of word designator
set iskeyword-=-
" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces
" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow
" Lines to scroll when cursor leaves screen
set scrolljump=1
" Minimum lines to keep above and below cursor
set scrolloff=10
set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set mouse=a
set number
set autoindent
set smartindent
set autochdir
set backspace=indent,eol,start
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
" Ignore case for commands
:set fileignorecase
set tabstop=4
set expandtab
set shiftwidth=4
set listchars=tab:›-,trail:•,extends:#,nbsp:.
" treat underscores as word breaks
set iskeyword-=_

"""
" Mappings
"""

" Pastetoggle (sane indentation on pastes)
set pastetoggle=<F12>

" Wrapped lines goes down/up to next row, rather than next line in file
noremap j gj
noremap k gk
" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>
" Sudo save
cmap w!! w !sudo tee % >/dev/null
" space saves everything
nmap <space> :wa!<cr>
" ctrl+c forces to quit without saving
nmap <C-c> :qa!<cr>
imap <C-c> <esc>:qa!<cr>
vmap <C-c> <esc>:qa!<cr>
" ctrl+z saves and closes current file
nmap <C-z> :wq!<cr>
imap <C-z> <esc>:wq!<cr>
vmap <C-z> <esc>:wq!<cr>
" shift+z saves and closes all files
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


"""
" Behavior
"""

" Reopen files at last location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" Be warned when > 80 chars
":au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Do not expand tabs in specified languages
autocmd FileType go,rust set noexpandtab
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell setlocal nospell
" Trim trailing whitespaces in specified languages
autocmd FileType obj,sql,vim,erlang,sh,conf,ruby,java,c,cpp,go,rust,php,javascript,python,twig,xml,yml,perl autocmd BufWritePre <buffer> call StripTrailingWhitespace()
function! StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

"""""""""""""
" NeoBundle "
"""""""""""""

if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('$HOME/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'bling/vim-airline'
NeoBundle 'fatih/vim-go'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'godlygeek/tabular'
NeoBundle 'jimenezrick/vimerl'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/VisIncr'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck


"""""""""""""""""""""""""
" Shougo/neosnippet.vim "
"""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/neosnippet.vim/"))

endif

""""""""""""""""""""""""""""""
" Shougo/neosnippet-snippets "
""""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/neosnippet-snippets/"))

endif

"""""""""""""""""""""""
" tpope/vim-fugitive  "
"""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))

"""
" Mappings
"""

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gi :Git add -p %<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>

endif

""""""""""""""""""
" kien/ctrlp.vim "
""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))

endif

""""""""""""""""""""""""""
" flazz/vim-colorschemes "
""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-colorschemes/"))

endif

""""""""""""""""""""""
" jimenezrick/vimerl "
""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vimerl/"))

endif

""""""""""""""""""""""""""
" Valloric/YouCompleteMe "
""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/YouCompleteMe/"))

"""
" Settings
"""

let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

endif

""""""""""""""""
" fatih/vim-go "
""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-go/"))

"""
" Settings
"""

let g:go_play_browser_command = 'google-chrome'
let g:go_play_open_browser = 1
let g:go_auto_type_info = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = ''
let g:go_fmt_fail_silently = 0
let g:go_doc_keywordprg_enabled = 1
let g:go_doc_command = "go doc"
let g:go_doc_options = ''
let g:go_bin_path = expand("$GOPATH/bin")
let g:go_snippet_engine = "neosnippet"
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 0
let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:go_loclist_height = 0

endif

""""""""""""""""""""""""""""""""
" terryma/vim-multiple-cursors "
""""""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-multiple-cursors/"))

endif

""""""""""""""""""""""""""""
" scrooloose/nerdcommenter "
""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/nerdcommenter/"))

"""
" Mappings
"""

" ctrl+j (un)toggles comment
nmap <C-j> <plug>NERDCommenterToggle
vmap <C-j> <plug>NERDCommenterToggle

endif

"""""""""""""""""""""
" godlygeek/tabular "
"""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/tabular/"))

"""
" Mappings
"""

nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

endif

"""""""""""""""""""""""
" osyo-manga/vim-over "
"""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-over/"))

endif

"""""""""""""""""""""
" bling/vim-airline "
"""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-airline/"))

endif

""""""""""""""""""""""""
" Raimondi/delimitMate "
""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/delimitMate/"))

endif

"""""""""""""""""""""""""
" kshenoy/vim-signature "
"""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-signature/"))

endif

""""""""""""""""""""""
" tpope/vim-surround "
""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-surround/"))

endif

"""""""""""""""""""""""
" vim-scripts/VisIncr "
"""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/VisIncr/"))

endif

""""""""""""""""""""""
" rust-lang/rust.vim "
""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/rust.vim/"))

endif
