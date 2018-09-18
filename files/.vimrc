""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Vuncle.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Package manager
Plugin 'VundleVim/Vundle.vim'
" Autocompletion
Plugin 'Valloric/YouCompleteMe'
" Generate ycm config files
Plugin 'rdnetto/YCM-generator'
" clang-format
Plugin 'rhysd/vim-clang-format'
" User defined operator
Plugin 'kana/vim-operator-user'
" Buffer management
Plugin 'jlanzarotta/bufexplorer'
" Statusline
Plugin 'itchyny/lightline.vim'
" Directory listings
Plugin 'scrooloose/nerdtree'
" Most recently used files
Plugin 'vim-scripts/mru.vim'
" Syntax checking
Plugin 'scrooloose/syntastic'
" Comment selection out
Plugin 'tpope/vim-commentary'
" Expand/shrink selection with +/_
Plugin 'terryma/vim-expand-region'
" Git
Plugin 'tpope/vim-fugitive'
" Stacking yank history
Plugin 'maxbrunsfeld/vim-yankstack'
" LESS syntax highlighting
Plugin 'groenewege/vim-less'
" Various colorschemes
Plugin 'flazz/vim-colorschemes'
" Python
Plugin 'klen/python-mode'
" Swap windows with <leader>ww
Plugin 'wesQ3/vim-windowswap'
" Beautify JS
Plugin 'maksimr/vim-jsbeautify'
" Preview markdown
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'suan/vim-instant-markdown'
" LaTeX
Plugin 'vim-latex/vim-latex'
" Vue.js
Plugin 'posva/vim-vue'
" Twig
Plugin 'lumiliet/vim-twig'
" TypeScript
Plugin 'leafgarland/typescript-vim'
" Indentation indicators
Plugin 'Yggdroot/indentLine'
" Multiple cursors
Plugin 'terryma/vim-multiple-cursors'
" UNIX helpers
Plugin 'tpope/vim-eunuch'
" s-selector for surroundings
Plugin 'tpope/vim-surround'
" 'Sensible' defaults
Plugin 'tpope/vim-sensible'
" Detect indentation
Plugin 'tpope/vim-sleuth'
" HTML, CSS, JS
Plugin 'mattn/emmet-vim'
" Git status indicators
Plugin 'airblade/vim-gitgutter'
" Fuzzy search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Markdown tables
Plugin 'dhruvasagar/vim-table-mode'
" Linting
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lines of history to remember
set history=500

" Automatically read when a file is changed outside the editor
set autoread

" Map leader to Space
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w<cr>

" :WW sudo saves the file
command WW w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 7 lines to the cursor when browsing with jk
set scrolloff=8

let $LANG='en'
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
    set gfn=Hack\ 10,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
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

set backupdir = "~/.vim/tmp/backup/'
set undodir = "~/.vim/tmp/undo/'
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
map <leader>bd :Bclose<cr>:tabclose<cr>gT

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
au TabLeave * let g:lasttab = tabpagenr()

" Open a new tab in the directory of the current buffer
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the current buffer
map <leader>cd :dc %:p:h<cr>:pwd<cr>

try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" System clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

vnoremap <silent> y y`]
vnoremap <silent> p p`]
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

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

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
map <leader>pp :sellocal paste!<cr>

vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Ack searching and cope displaying
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif

vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack
map <leader>g :Ack

" Search and replace selection
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fzf
map <leader>, :Files<CR>

" BufExplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

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

" TableMode
let g:table_mode_corner="|"

" ALE
let g:ale_c_parse_compile_commands = 1
let g:ale_c_parse_makefile = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Python
let g:syntastic_python_checkers=['pyflakes']

" Javascript
let g:syntastic_javascript_checkers = ['jshint']

" Go
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Custom CoffeeScript SyntasticCheck
func! SyntasticCheckCoffeescript()
    let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
    execute "tabedit " . l:filename
    execute "SyntasticCheck"
    execute "Errors"
endfunc
nnoremap <silent> <leader>c :call SyntasticCheckCoffeescript()<cr>

" Git gutter
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

" Markdown render
let vim_markdown_preview_github=0

" vim-latex
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_CompileRule_pdf="pdflatex -interaction=nonstopmode --shell-escape $*"

" Python mode
let g:pymode_python = 'python3'

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

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

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

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
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

vmap <silent> <expr> p <sid>Repl()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Command mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cno $h e ~/
cno $p e ~/code/projects/
cno $d e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>
cno $q <C-\>eDeleteTillSlash()<cr>

try
    colorscheme peaksea
catch
endtry
