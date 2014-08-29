
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle setup
filetype off    " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'inside/vim-search-pulse'
Plugin 'inside/vim-grep-operator'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'CursorLineCurrentWindow'
Plugin 'matze/vim-move'

" dev tools
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'Toggle'
"Plugin 'marijnh/tern_for_vim'

" Color Shemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'github-theme'

" Syntax
Plugin 'jelera/vim-javascript-syntax'
Plugin 'elzr/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'php.vim-for-php5'
Plugin 'vim-scripts/Sass'
Plugin 'plasticboy/vim-markdown'
Plugin 'beyondwords/vim-twig'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" End Vundle setup

" run shell commands in interactive mode
set shellcmdflag=-ic

" Should always have the same value for simplicity's sake "
set shiftwidth=4 tabstop=4 softtabstop=4
set expandtab

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup      " do not keep a backup file, use versions instead
else
    set backup        " keep a backup file (restore to previous version)
    set undofile      " keep an undo file (undo changes after closing)
endif
set history=50        " keep 50 lines of command line history
set ruler             " show the cursor position all the time
" set number          " line numbers
set relativenumber    " line number relative to cursor posiiton
" set colorcolumn=80  " Draws a vertical line at column 80
set cursorline        " Highlight the cursor screen line
set showcmd           " display incomplete commands
set incsearch         " do incremental searching
set clipboard=unnamed " share clipboard with mac os

" String to put at the start of lines that have been wrapped "
let &showbreak='↪ '

" remap <leader> on comma ','
let mapleader=','

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=8

" If 't_vb' is cleared and 'visualbell' is set, "
" no beep and no flash will ever occur "
set visualbell
set t_vb=

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Easy up and down on wrapped long lines
nnoremap j gj
nnoremap k gk

" Faster command mode
nnoremap ; :
nnoremap : ;

" Toogle comments (NERDCommenter)
nmap <leader>/ <leader>c<space>
vmap <leader>/ <leader>c<space>

" The nerdtree
nnoremap <leader>nt :NERDTreeToggle<cr>

" remap jk to escape
inoremap jk <esc>
inoremap <esc> <nop>

" save file whether in insert or normal mode "
inoremap <leader>s <c-o>:w<cr><esc>
nnoremap <leader>s :w<cr>

" SplitJoin Plugin config
nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>

" Toggle plugin config
noremap <leader>t :call Toggle()<cr>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" vim-move config
let g:move_map_keys = 0
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp

" Define indent movements similar to vim-move plugin shortcuts
" to move blocks around
nmap <C-h> <<
nmap <C-l> >>
vmap <C-h> <gv
vmap <C-l> >gv

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"    set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set t_Co=256
    set background=dark
    colorscheme solarized
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx

        " When sourcing multiple times your vimrc file
        " clear the autocommands first instead of adding them
        autocmd!
        " For Makefile files tabs are usefull
        autocmd FileType make setlocal noexpandtab
        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

" NERDTree conf
" show hidden files by default (I to toggle)
let NERDTreeShowHidden=1
" open a NERDTree automatically when vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-markdown configuration
let g:vim_markdown_initial_foldlevel=4

" vim-airline configuration
set encoding=utf-8
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='simple'
set laststatus=2

" vim-ctrlp configuration
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" vim-grep-operator config
set grepprg=git\ grep\ -n\ $*
nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt

" Tabularize config
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    "nmap <Leader>a: :Tabularize /:\zs<CR>
    "nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif
