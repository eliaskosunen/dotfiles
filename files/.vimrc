""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Vundle.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Package manager
Plugin 'VundleVim/Vundle.vim'
" clang-format
Plugin 'rhysd/vim-clang-format'
" Statusline
Plugin 'itchyny/lightline.vim'
" Directory listings
Plugin 'preservim/nerdtree'
" Most recently used files
Plugin 'yegappan/mru'
" Comment selection out
Plugin 'tpope/vim-commentary'
" Git
Plugin 'tpope/vim-fugitive'
" Stacking yank history
Plugin 'maxbrunsfeld/vim-yankstack'
" Various colorschemes
Plugin 'flazz/vim-colorschemes'
" Swap windows with <leader>ww
Plugin 'wesQ3/vim-windowswap'
" Beautify JS
Plugin 'maksimr/vim-jsbeautify'
" UNIX helpers
Plugin 'tpope/vim-eunuch'
" s-selector for surroundings
Plugin 'tpope/vim-surround'
" Detect indentation
Plugin 'tpope/vim-sleuth'
" HTML, CSS, JS
Plugin 'mattn/emmet-vim'

call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lines of history to remember
set history=500

" Automatically read when a file is changed outside the editor
set autoread

" Don't run settings embedded in opened files
set nomodeline

" Map leader to Space
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w<cr>

" :WW sudo saves the file
command! WW w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 7 lines to the cursor when browsing with jk
set scrolloff=8

set langmenu=en

" Set up WiLd menu
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Command bar height
set cmdheight=2

set hid

" Backspace configuration
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Configure search
set ignorecase
set smartcase
set hlsearch
set incsearch

set lazyredraw
set magic
set showmatch
set mat=2

" Disable error sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Enable 256 color-palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8
set encoding=utf8

" Use Unix standard file type
set ffs=unix,dos,mac

" Set font
if has("win16") || has("win32")
    set gfn=Hack:h10,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("linux") || has("gui_gtk2") || has("gui_gtk3")
    set gfn=Hack\ 9,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowb
set noswapfile

set undodir=~/.vim/tmp/undo//
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Spaces > tabs
set expandtab
set smarttab

" 1 tab is 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 200 chars
set lbr
set tw=200

" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Visual mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <leader><cr> disables highlighting
map <silent> <leader><cr> :noh<cr>

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close current buffer
map <leader>bd :Bclose<cr>

" Close all buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Tab mappings
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Toggle between the current and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
augroup last_tab
    autocmd!
    autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" Open a new tab in the directory of the current buffer
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the current buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files
augroup last_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Let yankstack set up its mappings first, so that the y and p mappings below
" take precedence
call yankstack#setup()

" System clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

vnoremap <silent> y y`]
nnoremap <silent> p p`]

" Move a line of text with ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

augroup clean_extra_spaces
    autocmd!
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Spellcheck
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle with <leader>ss
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z= 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove ^M on Windows
noremap <Leader>m mmHhmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer
map <leader>q :e ~/buffer<cr>
" Markdown buffer
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

augroup css_omnifunc
    autocmd!
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Search and replace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search and replace selection
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" MRU
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

" NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" Sleuth
if get(g:, '_has_set_default_indent_settings', 0) == 0
    set expandtab
    set tabstop=4
    set shiftwidth=4
    let g:_has_set_default_indent_settings = 1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

vnoremap <silent> <expr> p <sid>Repl()

try
    colorscheme peaksea
catch
endtry

" Indentation guides, one per shiftwidth, without conceal
set list
set listchars=tab:│\ ,trail:·
function! s:UpdateIndentGuides() abort
    let &l:listchars = &g:listchars
                \ . ',leadmultispace:│' . repeat(' ', shiftwidth() - 1)
endfunction
augroup indent_guides
    autocmd!
    autocmd ColorScheme * highlight SpecialKey ctermfg=238 guifg=#484848
    autocmd BufWinEnter,FileType * call s:UpdateIndentGuides()
    autocmd OptionSet shiftwidth,tabstop call s:UpdateIndentGuides()
augroup END
highlight SpecialKey ctermfg=238 guifg=#484848
