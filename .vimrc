"""""""""""""""""""""
""" Vimmortal v2.0 """
""""""""""""""""""""""

set nocompatible
colorscheme twilight256

set mouse=a

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
" '_' is an end of word designator
set iskeyword-=_
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
set number
set relativenumber
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
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v][vimmortal!]
set tabpagemax=99
" Ignore case for commands
:set fileignorecase
set tabstop=4
set expandtab
set shiftwidth=4
set listchars=tab:›-,trail:•,extends:#,nbsp:.

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
nmap tl :tabnext<cr>
nmap th :tabprevious<cr>
nmap tq :tabclose<cr>
map <C-h> :lp<CR>
map <C-l> :lne<CR>
nmap <C-_> o<CR>// -----------------------------------------------------------------------------<CR><CR><esc>
imap <C-_> // -----------------------------------------------------------------------------<CR><CR>
vmap <C-_> <esc>o<CR>// -----------------------------------------------------------------------------<CR><CR>


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
autocmd FileType obj,sql,vim,erlang,sh,conf,ruby,java,c,cpp,go,rust,php,javascript,js,json,python,twig,xml,yml,perl autocmd BufWritePre <buffer> call StripTrailingWhitespace()
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
NeoBundle 'Valloric/YouCompleteMe'
"NeoBundle 'Shougo/deoplete.nvim'
"NeoBundle 'zchee/deoplete-go', {'build': {'unix': 'make'}}
"NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'ervandew/supertab'
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
"NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/VisIncr'
NeoBundle 'sirver/ultisnips'
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'tpope/vim-unimpaired'
"NeoBundle 'vim-syntastic/syntastic'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

""""""""""""""""""""
" sirver/ultisnips "
""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/ultisnips/"))

"""
" Mappings
"""

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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

""""""""""""""""""""""""
" Shougo/deoplete.nvim "
""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/deoplete.nvim/"))

"""
" Settings
"""

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 32
let g:deoplete#auto_refresh_delay = 32

" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

endif

""""""""""""""""""""""""
" Shougo/neocomplete.nvim "
""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/neocomplete.vim/"))

"""
" Settings
"""

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_complete_delay = 32
let g:neocomplete#auto_refresh_delay = 32

" neocomplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

endif

""""""""""""""""""""""""""
" Valloric/YouCompleteMe "
""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/YouCompleteMe/"))

"""
" Settings
"""

let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_min_num_of_chars_for_completion = 1

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

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
let g:go_auto_type_info = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = ''
let g:go_fmt_fail_silently = 1
let g:go_doc_keywordprg_enabled = 1
let g:go_doc_command = "godoc"
let g:go_doc_options = ''
let g:go_bin_path = expand("$GOPATH/bin")
let g:go_snippet_engine = "ultisnips"
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
let g:go_highlight_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_autodetect_gopath = 1
" Remember to `gometalinter --install --update`
let g:go_metalinter_enabled = ['vet', 'vetshadow', 'golint', 'errcheck', 'gotype', 'structcheck', 'deadcode', 'dupl', 'interfacer']
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'vetshadow', 'golint', 'errcheck']
let g:go_loclist_height = 0
let g:go_auto_sameids = 1
let g:go_updatetime = 100
let g:go_alternate_mode = "vi"
let g:go_gocode_unimported_packages = 1
let g:go_list_type = "quickfix"
let g:go_def_mode = 'guru'

"""
" Mappings
"""

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>l <Plug>(go-metalinter)
au FileType go nmap <leader>d <Plug>(go-doc-tab)
au FileType go nmap <leader><CR> <Plug>(go-def-tab)
au FileType go nmap <leader>i <Plug>(go-implements)
au FileType go nmap <leader><leader> <Plug>(go-info)
au FileType go nmap <leader>x <Plug>(go-describe)
au FileType go nmap <leader>c <Plug>(go-channelpeers)

au FileType go nnoremap <silent> <leader>g :GoDeclsDir<CR>

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

""""""""""""""""""""""""""""""""
" kien/rainbow_parentheses.vim "
""""""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/rainbow_parentheses.vim"))

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

endif

"""""""""""""""""""""""""""
" vim-syntastic/syntastic "
"""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/syntastic"))

"""
" Settings
"""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_go_checker = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

endif
