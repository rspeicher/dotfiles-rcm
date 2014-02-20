set nocompatible
scriptencoding utf-8

" ------------------------------
" Basics
" ------------------------------

set backspace=2                   " Allow backspacing over everything in insert mode
set shortmess=atI
set scrolloff=5                   " Keep 5 lines above/below current while scrolling
set showcmd                       " Display incomplete commands
set wildmenu                      " Bash-like command line tab completion
set wildmode=longest,list
set wildignore=*.o,*.obj,*~,*.swp " Ignore when tab completing
set vb                            " No audible bell
set showmode                      " Display current mode
set hidden                        " Keep buffers
set nowrap                        " No line wrapping

" Use comma instead of backslash
let mapleader = ","

" ------------------------------
" Vundle
" ------------------------------

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
  map <Leader>VB :edit ~/.vimrc.bundles<CR>
endif

" ------------------------------
" Autocomplete
" ------------------------------

set complete=.,w,b,t

" ------------------------------
" Backups
" ------------------------------

set nobackup                      " No backups
set nowritebackup                 " No, really, no backups
set noswapfile                    " No swapfiles either
set backupdir=$HOME/.vim/backup   " Backup directory
set directory=~/.vim/swap,~/tmp,. " Swapfile directory

if v:version >= 730
  set undofile
  set undodir=~/.vim/swap,~/tmp,. " Backup file directory
endif

" ------------------------------
" Languages
" ------------------------------

syntax on
filetype plugin indent on
set tabstop=2 shiftwidth=2 expandtab " 2 spaces, no tabs

" Tab complete / tab width
au FileType python set omnifunc=pythoncomplete#Complete tabstop=4 shiftwidth=4
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType c set omnifunc=ccomplete#Complete
au FileType ruby,eruby set omnifunc=rubycomplete#Complete

" File types
au BufRead,BufNewFile Gemfile,Guardfile,Rakefile set ft=ruby
au BufRead,BufNewFile *.scss set ft=scss
au BufRead,BufNewFile *.less set ft=scss
au BufRead,BufNewFile *.sass set ft=sass
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile /usr/local/etc/nginx/* set ft=nginx

au FileType text setlocal textwidth=80

au BufReadPost fugitive://* set bufhidden=delete

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_klasses_in_global = 1
let g:rubycomplete_rails = 1

" ------------------------------
" Looks
" ------------------------------

set number        " Show line numbers
set numberwidth=5 " Gutter width
set ruler         " Show the cursor position all the time
set showmatch     " Show matching brackets
set mat=5         " Bracket blinking upon close
set laststatus=2  " Always show status line

if &term == "xterm-256color" || &term == "screen-256color" || has('gui_running')
  set t_Co=256
  colorscheme molokai
  highlight Folded guibg=#262626 guifg=#929292
endif

" Folding
set foldmethod=manual " Fold by syntax
set foldnestmax=3     " Deepest fold level
set nofoldenable      " Don't fold by default
set foldlevel=99      " Don't fold everything when we do enable folding
" nnoremap <Space> za
" vnoremap <Space> za

" Whitespace
set list listchars=tab:»·,trail:·

" ------------------------------
" Searching
" ------------------------------

set ignorecase " Search case insensitive, except...
set smartcase  " When there's a capital letter in the term
set incsearch  " Search incrementally

" Toggle search highlighting
map <Leader>L :set invhls <CR>

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ------------------------------
" Session
" ------------------------------

" Quick write session with F8
nmap <F8> :mksession! ~/.vim_session <cr>
" And load session with F11
nmap <F11> :source ~/.vim_session <cr>

" ------------------------------
" Windows
" ------------------------------

" Faster split navigation
nmap H <c-w>h
nmap J <c-w>j
nmap K <c-w>k
nmap L <c-w>l

" ------------------------------
" Miscellany
" ------------------------------

" Toggle paste mode, then tell us its current setting
map <F1> :set invpaste<CR>:set paste?<CR>

" Don't use Ex mode, use Q for formatting
vmap Q gq
nmap Q gqap

" Faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Speed up keymaps
set timeoutlen=500
set ttimeoutlen=10

" Go from insert back to normal with 'jk'
imap jk <Esc>

" Use 'gp' to select the pasted block in visual line mode
nnoremap gp V`]

" Map %% to be the directory of the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Inserts the path of the currently edited file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Toggle cursorcolumn
map <Leader>C :set invcursorcolumn<CR>

" Ruby/Rails: Edit Gemfile
command! Rgem :e Gemfile
command! RTgem :tabe Gemfile

" Command-T / Ctrl-P
set wildignore+=coverage/**,log/**,tmp/**
set wildignore+=*/cache/**
set wildignore+=*/tmp/**

" For when you forget to sudo. Really Write the file.
" cmap w!! w !sudo tee % >/dev/null

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

nnoremap <Leader><Leader> <c-^>

" Multipurpose tab key
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Quick macro to strip trailing whitespace
nnoremap @w :%s/\v\s+$//g<cr>

" ------------------------------
" Vim
" ------------------------------

" Quick editing of common dot-files
map <Leader>VV :edit $MYVIMRC<CR>

" Source vimrc after saving it
autocmd! BufWritePost .vimrc,vimrc,bundles.vim source $MYVIMRC
