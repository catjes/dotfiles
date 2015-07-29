" Sections:
"    -> Vundle
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Vimux
"    -> Turbux
"    -> NERDTree
"    -> Tags
"    -> Git
"    -> Commenting
"    -> Xmpfilter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " Must be first in .vimrc


filetype off
filetype plugin indent off
set runtimepath+=/usr/local/opt/go/libexec/misc/vim/
filetype plugin indent on
syntax on

autocmd FileType go autocmd BufWritePre <buffer> Fmt

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd
set showmode
set cursorline

" change the terminal window's title
set title

" Sets how many lines of history VIM has to remember
set history=1000

set undolevels=1000

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Save a keypress with ; instead of :
nnoremap ; :

" Use par for prettier line formatting
set formatprg=par\ -w72

" Clipboard fix for OsX
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use jj instead of <Esc>
imap jj <Esc>
imap jJ <Esc>

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/vendor/cache/*,*/public/system/*,*/tmp/*

"Always show current position
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set number
set relativenumber
set numberwidth=2

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Fix vim regex
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=3

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

 "Clear the search buffer on ,<space>
nnoremap <leader><leader> :noh<CR>

" Tab to move between bracket pairs
nnoremap <tab> %
vnoremap <tab> %


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

try
  colorscheme molokai
catch
endtry

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Don't wrap lines
set nowrap

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Backspace through everything in insert mode
set backspace=indent,eol,start

" Show whitespace at end of a line
set list listchars=tab:»·,trail:·

set matchpairs+=<:>


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

 "Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.rb :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! StripWhitespace()
  exec ':%s/ \+$//gc'
endfunction
map <leader>s :call StripWhitespace()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VimuxUseNearestPane = 1

" Prompt for a command to run
nmap <leader>rp :PromptVimTmuxCommand<CR>

" Run last command executed by RunVimTmuxCommand
nmap <leader>rl :RunLastVimTmuxCommand<CR>

" Close all other tmux panes in current window
nmap <leader>rx :CloseVimTmuxPanes<CR>

" Kill any command running in the runner pane
map <leader>rk :InterruptVimTmuxRunner<CR>

" If text is selected, save it in the v buffer and send to tmux
vmap <Leader>rs "vy:call VimuxRunCommand(@v . "\n", 0)<CR>

" Select current paragraph and send it to tmux
nmap <Leader>rs vip<Leader>rs<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turbux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:no_turbux_mappings = 1
nmap <leader>T <Plug>SendTestToTmux
nmap <leader>t <Plug>SendFocusedTestToTmux


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=1

map <C-s> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
map <leader>e :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags+=tags;$HOME
" Close tagbar after jumping to a tag
let g:tagbar_autoclose = 1
" Toggle tagbar
nmap <leader>tt :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:extradite_width = 60
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gg :Ggrep 
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <silent> <C-\> :Ggrep <cword><CR>:copen<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commenting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ,, <plug>NERDCommenterInvert

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Xmpfilter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <buffer> <leader>x <Plug>(xmpfilter-run)
xmap <buffer> <leader>x <Plug>(xmpfilter-run)
imap <buffer> <leader>x <Plug>(xmpfilter-run)

nmap <buffer> <leader>c <Plug>(xmpfilter-mark)
xmap <buffer> <leader>c <Plug>(xmpfilter-mark)
imap <buffer> <leader>c <Plug>(xmpfilter-mark)

"------------------------------------------------------------------------------
" Key Remappings
"------------------------------------------------------------------------------

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Move around in windows more easily
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>p <C-w>p

nmap <buffer> <CR> <C-]>

"------------------------------------------------------------------------------
" Powerline
"------------------------------------------------------------------------------

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

"------------------------------------------------------------------------------
" Rainbow Parentheses
"------------------------------------------------------------------------------

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"------------------------------------------------------------------------------
" The Platinum Searcher
"------------------------------------------------------------------------------
if executable('pt')
  " Use ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
