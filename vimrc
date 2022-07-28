" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugins
"Plugin 'L9'
"Plugin 'scrooloose/nerdtree'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'simplecommenter'
"Plugin 'pangloss/vim-javascript'
Plugin 'Yggdroot/indentLine'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
"Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"Plugin 'vim-utils/vim-alt-mappings'
"Plugin 'tell-k/vim-autopep8'
"Plugin 'othree/vim-autocomplpop'
"Plugin 'marcweber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmat'
"Plugin 'honza/vim-snippets'
"Plugin 'ruanyl/vim-fixmyjs'
Plugin 'kien/ctrlp.vim'
"Plugin 'rking/ag.vim'
"Plugin 'mileszs/ack.vim'
Plugin 'chase/vim-ansible-yaml'
"Plugin 'avakhov/vim-yaml'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'suan/vim-instant-markdown'
"Plugin 'isnowfy/python-vim-instant-markdown'

call vundle#end()

let g:indentLine_color_term = 239
" set linter for syntastic
let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_sass_checkers=["sass_lint"]
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set ctrlp ignore dir (for node)
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|.pyc'

" set yaml and ignore blank_line
"au BufNewFile,BufRead *.yaml set filetype=ansible
"let g:ansible_options = {'ignore_blank_lines': 0}

"set list lcs=tab:\|\
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

au BufNewFile,BufRead Dockerfile* set filetype=conf
au FileType python setl ts=4 sw=4 sts=4 et
au FileType html* setl ts=2 sw=2 sts=2 et
au FileType sass setl ts=2 sw=2 sts=2 et
au FileType javascript setl ts=4 sw=4 sts=4 et

set tabpagemax=200

"set rtp+=~/.vim/mybundle/matlabvimcolours

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
    syntax on
endif


" auto reload vimrc
autocmd! BufWritePost .vimrc source %
autocmd! BufWritePost vimrc source %

" set pentadactyl rc filetype
"au BufRead,BufNewFile *.penta set filetype=pentadactyl

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let javascript_enable_domhtmlcss=1  

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
    filetype plugin indent on
    filetype on
    filetype indent on
endif

" color setting
if $TERM == "xterm-256color" || $TERM == "screen-256color"
    " set 256 colors
    set t_Co=256
    colors default
elseif $TERM == "xterm"
    set t_Co=16
endif


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd			" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase 		" Ignore case when search
"set smartcase
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set ruler			" Show lines % at bottom
set completeopt=menuone,menu,longest,preview
set scrolloff=50	" Maintain more context around the cursor
set relativenumber	" Show relative line number 
set clipboard=unnamedplus " share clipboard w/ system
set wildmenu		" Make file/command completion useful. To have the completion behave similarly to a shell
set wildmode=list:longest
set autoindent		" Auto indent
"set fileencodings=big5,gb2312,gb18030,gbk,utf-8,latin1,default
"set fencs=utf-8,big5,gbk,gb2312,cp936,default
"set fileencoding=utf-8
set bs=2		" vim 7.3 backspace not work
set backspace=indent,eol,start

" set undo dir path
try
    set undodir=~/.vim/undo
    set undofile
catch
endtry
" set swap file dir path
set directory=$HOME/.vim/swapfiles//

let g:clang_user_options='|| exit 0'
let mapleader=','	" set leader key 

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Catch trailing whitespace 
" The following will make tabs and trailing spaces
" visible when requested: 
set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>
" map fixjs
nmap <silent> <leader>f :Fixmyjs<CR>:w<CR>

nmap ; :
vmap ; :

" tab relative control
nmap t :tabnew 
nmap <C-h>  gT
nmap <C-j>  gt
nmap <C-k>  gT
nmap <C-l>  gt
nmap <S-h>  gT
nmap <S-j>  gt
nmap <S-k>  gT
nmap <S-l>  gt
" ctrl-tab only works on gui
nmap <C-Tab>  gt

" cursor moving
imap <C-d>  <DEL>
imap <C-a>  <HOME>
imap <C-e>  <END>
imap <C-f>  <RIGHT>
imap <C-b>  <LEFT>

" match % to match more than just single characters (like html tag)
"   ref: http://www.vim.org/scripts/script.php?script_id=39
source $VIMRUNTIME/macros/matchit.vim

" NERDTree config
let NERDTreeQuitOnOpen=1
nmap <Leader>n  :NERDTreeToggle<CR>

" simplecommenter config
let g:oneline_comment_padding=''

" make move-word work in tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif


if has("gui_running")
    " set colors
    colors torte 
    set cursorline

    " window size
    set lines=40
    set columns=100

    " hide tool bar
    set guioptions-=e " don't use gui tab apperance
    set guioptions-=T " hide toolbar
    set guioptions-=m " hide menubar
    set guioptions-=r " don't show scrollbars
    set guioptions-=l " don't show scrollbars
    set guioptions-=R " don't show scrollbars
    set guioptions-=L " don't show scrollbars
    set guioptions+=c " use console dialog rather than popup dialog

    " disable input manager
"     set imdisable
    set antialias

    set guifont=Monospace\ 13
    if has("gui_macvim")
        " set CMD+ENTER fullscreen
        set fuopt=maxhorz,maxvert
        " for eclim <cmd + shift + L>
        "map <D-L> :ProjectList<CR>
        "map <D-C> :ProjectCreate
        "map <D-E> :ProjectTree<CR>
        "map <D-D> :ProjectDelete
    endif
endif
