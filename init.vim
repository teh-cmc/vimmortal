"""""""""""""""""""""""""""
""" (neo)Vimmortal v5.0 """
"""""""""""""""""""""""""""

set nocompatible
set mouse=a

set background=dark

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" BUILT-INS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Common programs """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set grepprg=rg\ --vimgrep\ --smart-case

"" Global editing settings """""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on

" Syntax highlighting with 24-bit colors!
syntax on
set termguicolors

set cmdheight=1
set noautochdir
" UTF-8 everywhere
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
" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces
" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow
" Lines to scroll when cursor leaves screen
set scrolljump=1
" Minimum lines to keep above and below cursor
set scrolloff=5
" Display size of visual selection
set showcmd
" Show matching [, (, etc... for 'matchtime' tenth of seconds
set showmatch matchtime=3
let loaded_matchparen=0
" Smart case
set ignorecase smartcase
" Highlight search pattern as you type
set hlsearch incsearch
" Automatically write the file before a :make, :next, etc...
set autowrite
" Automatically reload files modified by external program
set autoread
" Display current line-number and relative positions of adjacent lines
set number relativenumber
" Try and auto-indent new lines somewhat smartly
set autoindent smartindent
" Backspace will happily destroy anything in insert mode
set backspace=indent,eol,start
" Disable bell sounds on errors
set noerrorbells
set wildmenu wildmode=list:longest
" Highlight current line
set cursorline
" Always display status line
set laststatus=2
" Don't redraw after commands that don't have visual effects
set lazyredraw
" No extra pixels between lines
set linespace=0
" Display 'listchars' in virtual text
set list listchars=tab:›-,trail:•,extends:#,nbsp:.
" Try to land in the same column when doing long jumps
set nostartofline
" Minimal number of columns to use for the line number
set numberwidth=4
" Threshold for reporting number of lines changed, 0 means always
set report=0
" Max open tabs
set tabpagemax=99
" Ignore case for commands
set fileignorecase
" Dedicate up to 50MB of RAM for pattern-maching operations (e.g. syntax highlighting)
set maxmempattern=50000
" Always cd into current buffer's directory (not a good idea in a fzf world)
" set autochdir

" '.', '#', '-' & '_' are all word boundaries
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set iskeyword-=_

"" Default behavior for tabs

" Tabs are always expanded into for 4 spaces by default
set tabstop=4 shiftwidth=4 expandtab
" No maximum line-width by default
set textwidth=0
" Display a vertical bar at textwidth+1 columns
set colorcolumn=+1

"" Clipboards

" Make sure that vim shares the main OS yank registers
if has('clipboard')
    " When possible use + register for copy-paste
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else
        " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

"" Metadata files

" Persitent undo settings
if has('persistent_undo')
    set undofile
    " Maximum number of changes that can be undone
    set undolevels=1000
    " Maximum number lines to save for undo on a buffer reload
    set undoreload=10000
endif

" Put swap/undo/info files in one neat place
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif
set directory=$HOME/.vim/files/swap/
set updatecount =100
set undofile
set undodir=$HOME/.vim/files/undo/
set viminfo='100,n$HOME/.vim/files/info/viminfo

"" Global mappings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pastetoggle (sane indentation on pastes)
set pastetoggle=<F12>

let mapleader = ','

nnoremap <leader>c :cwindow<CR>
nnoremap <leader>l :lwindow<CR>

" Clear search highlight
nnoremap <leader><space> :noh<CR>

" Sane navigation bindings in command-mode
cnoremap <C-n> <down>
cnoremap <C-p> <up>
cnoremap <C-a> <left>
cnoremap <C-b> <right>

" Easier quick window navigation
nnoremap <silent> <C-h> :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-j> :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-l> :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>

" Searching for next/previous occurence will center the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Scrolling until next/previous screen will recenter the screen
noremap <C-f> <C-f>zz
noremap <C-b> <C-b>zz

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

" Sudo save in command-line
cnoremap w!! w !sudo tee % >/dev/null

" <space> saves everything
nnoremap <space> :wa!<cr>
" <C-c> drops everything
nnoremap <C-c> :qa!<cr>
inoremap <C-c> :qa!<cr>
vnoremap <C-c> :qa!<cr>
" <C-z> save-quits current buffer
nnoremap <C-z> :wq!<cr>
inoremap <C-z> :wq!<cr>
vnoremap <C-z> :wq!<cr>
" <S-z> save-quits everything
nnoremap <S-z> :wqa!<cr>
vnoremap <S-z> :wqa!<cr>

" Open current buffer in a new tab
nnoremap tt :tab split<CR>
" Saner tab navigation
nnoremap tl :tabnext<cr>
nnoremap th :tabprevious<cr>
nnoremap tq :tabclose<cr>

" TODO(cmc): make a real function wtf is this
nnoremap <C-_> o<CR>// -----------------------------------------------------------------------------<esc>

" nnoremap <C-h> :lp<CR>
" nnoremap <C-l> :lne<CR>

"" Global hooks """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup globalHooks
    autocmd!

    " NOTE(cmc): Disabled; provided by vim-qf instead.
    " Close vim if quickfix window is last window
    " autocmd BufEnter * call MyLastWindow()
    " function! MyLastWindow()
    "   " if the window is quickfix go on
    "   if &buftype=="quickfix"
    "     " if this window is last on screen quit without warning
    "     if winbufnr(2) == -1
    "       quit!
    "     endif
    "   endif
    " endfunction

    " NOTE(cmc): Disabled; provided by vim-qf instead.
    " Make sure quickfix window is always at the bottom
    " autocmd FileType qf wincmd J
    " autocmd FileType qf setlocal wrap

    " Always trim trailing whitespaces for everything but
    let blacklist_trimspace = ['markdown']
    autocmd BufWritePre * if index(blacklist_trimspace, &ft) < 0 | call StripTrailingWhitespace()
    function! StripTrailingWhitespace()
        let _s=@/
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        let @/=_s
        call cursor(l, c)
    endfunction

    " 80-chars limit per line for everything but
    " TODO(cmc): override default tw=80 for vimscript (wtf neovim?)
    let blacklist_textwidth80 = ['markdown','json','vim']
    autocmd FileType * if index(blacklist_textwidth80, &ft) < 0 | setlocal textwidth=80

    " Reopen files at last location
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Instead of reverting the cursor to the last position in the buffer, we set it
    " to the first line when editing a git commit message
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    autocmd BufNewFile,BufRead *.cql set filetype=sql
    autocmd BufNewFile,BufRead todo set filetype=todo
    autocmd FileType todo autocmd BufWritePre todo :%sort
    autocmd FileType todo autocmd BufWritePre todo :%s#\[x\] (\d)#[x]#ge
    autocmd FileType todo autocmd BufWritePre todo :%s#^\n##ge
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug will self-install if necessary
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" Everything language-specific is done via LSP integration.
call plug#begin('~/.vim/bundle')

"" Listing """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Filetypes
let plugin_ft_capnp = 'peter-edge/vim-capnp' " filetype support for Cap'n Proto
let plugin_ft_fbs = 'zchee/vim-flatbuffers' " filetype support for FlatBuffers
let plugin_ft_qml = 'peterhoeg/vim-qml' " filetype support for Qt's QML
let plugin_ft_snes = 'ARM9/snes-syntax-vim' " filetype support for 65816, spc700 and SuperFX assembly
let plugin_ft_tmux = 'tmux-plugins/vim-tmux' " filetype support for tmux.conf
let plugin_ft_toml = 'cespare/vim-toml' " filetype support for TOML
let plugin_ft_zig = 'ziglang/zig.vim' " filetype support for Zig
let plugin_ft_gql = 'jparise/vim-graphql' " filetype support for GraphQL

"" External integrations
let plugin_intgr_fzf = 'junegunn/fzf.vim' " fzf integration
let plugin_intgr_git = 'tpope/vim-fugitive' " heavyweight git integration
let plugin_intgr_github = 'tpope/vim-rhubarb' " heavyweight github integration
let plugin_intgr_github_simple = 'danishprakash/vim-githubinator' " lightweight github integration
let plugin_intgr_gitgutter = 'airblade/vim-gitgutter' " git status gutter and (way too) much more
let plugin_intgr_tmux = 'christoomey/vim-tmux-navigator' " tmux transparent pane-switching
let plugin_intgr_tmuxstatus = 'edkolev/tmuxline.vim' " tmux status line generator matching lightline

"" QOL improvements & extra features
let plugin_qol_choosewin = 't9md/vim-choosewin' " C-w done right
let plugin_qol_commentary = 'tpope/vim-commentary' " toggle/untoggle comments
let plugin_qol_incrseq = 'vim-scripts/VisIncr' " generate sequences of integers, dates, etc...
let plugin_qol_localvimrc = 'embear/vim-localvimrc' " support for per-project vimrc files
let plugin_qol_multicursor = 'mg979/vim-visual-multi' " multi-cursor implementation that actually works
let plugin_qol_over = 'osyo-manga/vim-over' " live preview for s/
let plugin_qol_qftamer = 'romainl/vim-qf' " saner defaults for quickfix/location windows
let plugin_qol_rainbow = 'kien/rainbow_parentheses.vim' " multi-color matching [, (, etc...
let plugin_qol_repeat = 'tpope/vim-repeat' " makes . work with <Plug> mappings
let plugin_qol_speeddating = 'tpope/vim-speeddating' " makes C-a/C-x work with dates
let plugin_qol_splitjoin = 'AndrewRadev/splitjoin.vim' " join blocks into single-lines and vise-versa
let plugin_qol_startify = 'mhinz/vim-startify' " boot-screen and session manager
let plugin_qol_surround = 'tpope/vim-surround' " mappings to enclose stuff in [, (, etc...
let plugin_qol_tabular = 'godlygeek/tabular' " automatic text alignment done right
let plugin_qol_targets = 'wellle/targets.vim' " improved text objects
let plugin_qol_unimpaired = 'tpope/vim-unimpaired' " next/previous mappings for all kinds of stuff
let plugin_qol_visualstar = 'thinca/vim-visualstar' " makes * work on visual selections
let plugin_qol_rooter = 'airblade/vim-rooter' " autchdir to nearest git root
let plugin_qol_gitmsg = 'rhysd/git-messenger.vim' " shows commit message under cursor
let plugin_qol_signature = 'kshenoy/vim-signature' " shows marks in the gutter
" TODO(cmc): zirrostig/vim-schlepp?

"" UI
let plugin_ui_colorschemes = 'flazz/vim-colorschemes' " fancy colorscheme pack
let plugin_ui_lightline = 'itchyny/lightline.vim' " orthogonal status bar

"" Completion
let plugin_completion_ycm = 'Valloric/YouCompleteMe' " heavyweight completion engine
let plugin_completion_ultisnips = 'SirVer/ultisnips' " snippet engine
let plugin_completion_snippets = 'honza/vim-snippets' " snippet library
let plugin_completion_lsc = 'natebosch/vim-lsc' " lightweight, orthogonal native LSP support
let plugin_completion_coc = 'neoclide/coc.nvim' " heavyweight LSP support with VSCode bindings
let plugin_completion_deoplete = 'Shougo/deoplete.nvim' " heavyweight completion engine
let plugin_completion_lcn = 'autozimu/LanguageClient-neovim' " lightweight, orthogonal Rust-based LSP support

let plugins={
\   plugin_ft_snes:   1,
\   plugin_ft_toml:   1,
\   plugin_ft_capnp:  1,
\   plugin_ft_qml:    1,
\   plugin_ft_tmux:   1,
\   plugin_ft_fbs:    1,
\   plugin_ft_zig:    1,
\   plugin_ft_gql:    1,
\
\   plugin_intgr_fzf:            1,
\   plugin_intgr_git:            0,
\   plugin_intgr_github:         0,
\   plugin_intgr_github_simple:  1,
\   plugin_intgr_gitgutter:      1,
\   plugin_intgr_tmux:           1,
\   plugin_intgr_tmuxstatus:     1,
\
\   plugin_qol_choosewin:    1,
\   plugin_qol_commentary:   1,
\   plugin_qol_incrseq:      1,
\   plugin_qol_localvimrc:   1,
\   plugin_qol_multicursor:  1,
\   plugin_qol_over:         1,
\   plugin_qol_qftamer:      1,
\   plugin_qol_rainbow:      1,
\   plugin_qol_repeat:       1,
\   plugin_qol_speeddating:  1,
\   plugin_qol_splitjoin:    1,
\   plugin_qol_startify:     1,
\   plugin_qol_surround:     1,
\   plugin_qol_tabular:      1,
\   plugin_qol_targets:      1,
\   plugin_qol_unimpaired:   1,
\   plugin_qol_visualstar:   1,
\   plugin_qol_rooter:       1,
\   plugin_qol_gitmsg:       1,
\   plugin_qol_signature:    1,
\
\   plugin_ui_colorschemes:  1,
\   plugin_ui_lightline:     1,
\
\   plugin_completion_ycm:        0,
\   plugin_completion_ultisnips:  1,
\   plugin_completion_snippets:   1,
\   plugin_completion_lsc:        0,
\   plugin_completion_coc:        1,
\   plugin_completion_deoplete:   0,
\   plugin_completion_lcn:        0,
\}

let plugins_instr = {
\   plugin_completion_coc:        { 'branch': 'release' },
\   plugin_completion_deoplete:   { 'do': ':UpdateRemotePlugins' },
\   plugin_completion_lcn:        { 'branch': 'next', 'do': 'bash install.sh' },
\}

for [pname, penabled] in items(plugins)
    if penabled
        if has_key(plugins_instr, pname)
            let instr = plugins_instr[pname]
            Plug pname, instr
        else
            Plug pname
        endif
    endif
endfor

call plug#end()

"" flazz/vim-colorschemes' """""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_ui_colorschemes]
    colorscheme molokai_dark
endif

"" kien/rainbow_parentheses.vim """"""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_qol_rainbow]
    augroup rainbowParentheses
        autocmd!

        autocmd VimEnter * RainbowParenthesesToggle
        autocmd Syntax * RainbowParenthesesLoadRound
        autocmd Syntax * RainbowParenthesesLoadSquare
        autocmd Syntax * RainbowParenthesesLoadBraces
    augroup END
endif

"" t9md/vim-choosewin """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_qol_choosewin]
    nnoremap - :ChooseWin<CR>
    nnoremap <C-w>w :ChooseWin<CR>
endif

let g:choosewin_overlay_enable = 0

""

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

"" AndrewRadev/splitjoin.vim """""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_qol_splitjoin]
    let g:splitjoin_split_mapping = ''
    let g:splitjoin_join_mapping = ''

    nnoremap Xj :SplitjoinSplit<cr>
    nnoremap Xk :SplitjoinJoin<cr>
endif

"" airblade/vim-gitgutter """"""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO(cmc): worth having a look at what's possible
" TODO(cmc): disable auto, only on write
"
if plugins[plugin_intgr_gitgutter]
endif

"" embear/vim-localvimrc """""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_qol_localvimrc]
    let g:localvimrc_ask = 0
endif

"" godlygeek/tabular """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_qol_tabular]
    nnoremap <Leader>t& :Tabularize /&<CR>
    vnoremap <Leader>t& :Tabularize /&<CR>
    nnoremap <Leader>t= :Tabularize /=<CR>
    vnoremap <Leader>t= :Tabularize /=<CR>
    nnoremap <Leader>t: :Tabularize /:<CR>
    vnoremap <Leader>t: :Tabularize /:<CR>
    nnoremap <Leader>t:: :Tabularize /:\zs<CR>
    vnoremap <Leader>t:: :Tabularize /:\zs<CR>
    nnoremap <Leader>t, :Tabularize /,<CR>
    vnoremap <Leader>t, :Tabularize /,<CR>
    nnoremap <Leader>t,, :Tabularize /,\zs<CR>
    vnoremap <Leader>t,, :Tabularize /,\zs<CR>
    nnoremap <Leader>t<Bar> :Tabularize /<Bar><CR>
    vnoremap <Leader>t<Bar> :Tabularize /<Bar><CR>
endif

"" itchyny/lightline.vim """""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_ui_lightline]
    if plugins[plugin_completion_coc]
        autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

        function! CocCurrentFunction()
            return get(b:, 'coc_current_function', '')
        endfunction

        let g:lightline = {
        \   'colorscheme': 'one',
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ],
        \               [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
        \   },
        \   'component': {
        \     'filename': '%F'
        \   },
        \   'component_function': {
        \     'cocstatus': 'coc#status',
        \     'currentfunction': 'CocCurrentFunction'
        \   },
        \}
    else
        let g:lightline = {
        \   'colorscheme': 'one',
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ],
        \               [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \   },
        \   'component': {
        \     'filename': '%F'
        \   },
        \}
    endif
endif

"" junegunn/fzf.vim """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_intgr_fzf] && !plugins[plugin_completion_coc]
    set rtp+=~/.fzf

    let g:fzf_command_prefix = 'Fzf'

    nnoremap ;b :FzfBuffers<CR>
    nnoremap ;f :FzfFiles<CR>
    nnoremap ;t :FzfTags<CR>
    " TODO(cmc): whole workspace
    nnoremap ;A :FzfAg<CR>
    " TODO(cmc): current buffer
    nnoremap ;a :FzfAg<CR>
    nnoremap ;h :FzfHistory<CR>
    nnoremap ;m :FzfMarks<CR>
endif

"" Valloric/YouCompleteMe """"""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_completion_ycm]
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_seed_identifiers_with_syntax = 0

    let g:ycm_add_preview_to_completeopt = 0
    set completeopt-=preview

    let g:ycm_key_list_stop_completion = ['<C-y>']
endif

"" Shougo/deoplete """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_completion_deoplete]
    let g:deoplete#enable_at_startup = 1
endif

"" danishprakash/vim-githubinator """"""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_intgr_github_simple]
    let g:githubinator_no_default_mapping = 0
endif

"" SirVer/ultisnips """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_completion_ultisnips]
    let g:UltiSnipsExpandTrigger="<C-e>"
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-k>"

    if plugins[plugin_completion_coc]
        let g:UltiSnipsExpandTrigger="<C-p>"
    endif
endif

"" natebosh/vim-lsc """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_completion_lsc]
    let g:lsc_auto_map = {
        \ 'GoToDefinition': 'gd',
        \ 'FindReferences': 'gr',
        \ 'NextReference': '<C-n>',
        \ 'PreviousReference': '<C-p>',
        \ 'FindImplementations': 'gI',
        \ 'FindCodeActions': 'ga',
        \ 'Rename': 'gR',
        \ 'ShowHover': v:true,
        \ 'DocumentSymbol': 'go',
        \ 'WorkspaceSymbol': 'gS',
        \ 'SignatureHelp': '<leader>,',
        \ 'Completion': 'omnifunc',
        \}

    let g:lsc_server_commands = {
        \ 'go': {
        \    'command': 'go-langserver',
        \    'message_hooks': {
        \        'initialize': {
        \            'initializationOptions': {
        \               'gocodeCompletionEnabled': v:true,
        \               'diagnosticsEnabled': v:true,
        \               'lintTool': 'golint',
        \               'goimportsLocalPrefix': 'github.com/znly',
        \               'useBinaryPkgCache': v:true
        \            },
        \        },
        \    },
        \  },
        \}

    let g:lsc_enable_autocomplete = v:true
    let g:lsc_snippet_support = v:true
endif

"" neoclide/coc.nvim """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_completion_coc]
    "" Programs

    "" Commands

    command! -nargs=0 Format :call CocAction('format')
    command! -nargs=0 Highlight :call CocActionAsync('highlight')
    command! -nargs=? Fold   :call CocAction('fold', <f-args>)

    "" Hooks

    augroup coc
        autocmd!

        autocmd FileType json syntax match Comment +\/\/.\+$+
        autocmd Filetype rust,go,json autocmd CursorHold * :Highlight
        autocmd FileType rust,go,json autocmd BufWritePre * :Format
    augroup END

    "" Mappings

    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300

    nnoremap <silent><leader>, :call CocAction('showSignatureHelp')<CR>
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    " Use <tab>/<S-tab> to cycle through completions
    inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<tab>"
    inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<tab>"
    inoremap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
    inoremap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
    let g:coc_snippet_next = '<C-j>'
    let g:coc_snippet_previous = '<C-k>'

    " Expand snippets with <CR> or <C-e>
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
    inoremap <expr> <C-e> pumvisible() ? "\<C-y>" : "\<C-e>"

    " Manually trigger completion with <C-space>
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> <leader>d <Plug>(coc-diagnostic-info)
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Goto definition & friends
    nmap gd <Plug>(coc-definition)
    nmap gy <Plug>(coc-type-definition)
    nmap gi <Plug>(coc-implementation)
    nmap gr <Plug>(coc-references)

    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    nmap <leader>rf <Plug>(coc-refactor)
    nmap <leader>rn <Plug>(coc-rename)

    vmap <leader>f <Plug>(coc-format-selected)

    nmap <leader>aa <Plug>(coc-fix-current)
    vmap <leader>aa <Plug>(coc-codeaction-selected)

    nmap <leader>ac <Plug>(coc-codeaction)
    nmap <leader>qf <Plug>(coc-fix-current)

    nnoremap ;; :CocListResume<CR>
    nnoremap ;b :CocList buffers<CR>
    nnoremap ;f :CocList files<CR>
    nnoremap ;w :CocList windows<CR>
    nnoremap ;t :CocList tags<CR>
    nnoremap ;m :CocList marks<CR>
    nnoremap ;s :CocList outline<CR>
    nnoremap ;S :CocList symbols<CR>
    nnoremap ;d :CocList diagnostics<CR>
    nnoremap ;l :CocList links<CR>
    nnoremap ;c :CocList commands<CR>
    nnoremap ;h :CocList cmdhistory<CR>
    nnoremap ;a :CocList grep<CR>

    function! s:GrepArgs(...)
      let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
            \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
      return join(list, "\n")
    endfunction
    command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

    nnoremap <silent> <Leader>A :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

endif

"" autozimu/LanguageClient-neovim """"""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_completion_lcn]
    let g:LanguageClient_serverCommands = {
     \  'go': ['gopls', '-mode', 'kek' ],
     \}

    if plugins[plugin_completion_deoplete]
        let g:deoplete#enable_at_startup = 1
    endif

    function SetLSPShortcuts()
      nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
      nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
      nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
      nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
      nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
      nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
      nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
      nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
      nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
      nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    endfunction()

    augroup LSP
      autocmd!
      autocmd FileType cpp,c call SetLSPShortcuts()
    augroup END

endif

"" tpope/vim-commentary """"""""""""""""""""""""""""""""""""""""""""""""""""""""

if plugins[plugin_qol_commentary]
    " nnoremap <leader>c :Commentary<CR>
    " vnoremap <leader>c :Commentary<CR>

    " TODO(cmc): that really shouldn't be here (-> global language hooks)
    autocmd FileType json setlocal commentstring=//\ %s
endif

"" airblade/vim-rooter """""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:rooter_patterns = ['.rustfmt.toml', 'go.mod', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']

"" mhinz/vim-startify """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

"" romainl/vim-qf """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap QQ <Plug>(qf_qf_toggle_stay)
nmap LL <Plug>(qf_loc_toggle_stay)

nmap [l <Plug>(qf_loc_previous)
nmap ]l <Plug>(qf_loc_next)
nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)

let g:qf_window_bottom = 1
let g:qf_loclist_window_bottom = 1

"" mg979/vim-visual-multi """"""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO(cmc): sane previous mapping

if plugins[plugin_qol_multicursor]
" Do *not* break <C-f>, ever
let g:VM_default_mappings = 0
endif
