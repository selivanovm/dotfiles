" Detect the OS now ------------------------------------------------------- {{{

let g:os = "unknown"
if has('win32')
    let g:os = "windows"
else " Assume it is UNIX with uname
    let uname = substitute(system('uname'), "\n", "", "")
    if uname == "SunOS"
        let g:os = "sun"
    elseif uname == "Linux"
        let g:os = "linux"
    elseif uname == "Darwin"
        let g:os = "osx"
    endif
endif

" }}}
" General configuration --------------------------------------------------- {{{

filetype off

" GO!
set rtp+=$GOROOT/misc/vim

" Pathogen support
call pathogen#runtime_append_all_bundles()

" Needed to enable plugin indent after calling pathogen#... because some
" plugins have a strange behavior sometimes.
filetype plugin indent on

" Remove Vi compatibility
set nocompatible

" Prevent security exploits with modelines files
set modelines=0

" Backups {{{

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile

" }}}

" }}}
" Editor basics ----------------------------------------------------------- {{{

set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set novisualbell
set cursorline
set ttyfast
set ruler
set list
set backspace=indent,eol,start
set listchars=tab:\▸\ ,eol:¬,nbsp:·
set laststatus=2
set wrap
set textwidth=80
set formatoptions=qrn1tc
set colorcolumn=+1
set list
setglobal number
setglobal rnu
syntax on

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
" }}}
" Automatic file saving on focus lost {{{

au FocusLost * :wa
au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

" }}}
" Code folding {{{

set foldlevelstart=0
set foldmethod=marker
set foldnestmax=10
set foldenable

" Make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be.
nnoremap zO zCzO

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" }}}
" Leaders ----------------------------------------------------------------- {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}
" Basic shortcuts --------------------------------------------------------- {{{

" TextMate hard rewrap
nnoremap <leader>q gqip

" Open .vimrc in a separated split
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Open a vertical split
nnoremap <leader>w <C-w>v<C-w>l
" Open an horizontal split.
nnoremap <leader>e :split<CR>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Select whole file
nnoremap <leader>vf ggVG

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Save my cap key
nmap ; :

" $ and ^ are too far
noremap L $
noremap H ^
noremap K <C-U>
noremap J <C-D>

" Activate <tab> to switch between brackets
nnoremap <tab> %
vnoremap <tab> %

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

" Easy replacement
nnoremap <leader>s :%s//g<left><left>

" Bind [ and ] to ^ and $ for an easier navigation
nmap <leader>[ ^
nmap <leader>] $

" Redo
nnoremap U <C-r>

" Buffer switch
nnoremap <leader>l :BufExplorer<CR>

" Close that window
noremap <leader>Q :q<CR>

" Open file
nnoremap <leader>o <C-w><C-v><C-l>:CommandT<CR>

" Remove the word under the cursor
nnoremap <leader>d diw

" Spellchecking
nnoremap <leader>sf :setlocal spell spelllang=fr<cr>
nnoremap <leader>se :setlocal spell spelllang=en_us<cr>

" Source
vnoremap <leader>S y:execute @@<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>

" Select (linewise) the text you just pasted (handy for modifying indentation) 
nnoremap <leader>v V`]

" Save my life.
cnoreabbrev W w

" List the fixmes/todos in the current directory.
nnoremap <leader>0 :vimgrep /TODO\\|FIXME/ **/*<CR>:cw<CR>

" Add awesome grep.
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<C-U>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

" Folding {{{

" Unfold all the document
nnoremap <leader>E zR
nnoremap <leader>D zM

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

" }}}
" Searching {{{

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" Remove highlight for the current search
nnoremap <leader><space> : noh<cr>

" }}}

" }}}
" Edition commands -------------------------------------------------------- {{{

" Fill rest of line with characters {{{
function! FillLine( str )
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" Fill the current line with dashes and replace the last 4 characters by
" markers.
nnoremap <leader>K mq:call FillLine('-')<cr>`qA<esc>xxxxa {<esc>a{{<esc>
nnoremap <leader>k mq:call FillLine('-')<cr>`qA

" }}}

" }}}
" Visual ------------------------------------------------------------------ {{{
" (this title is probably poorly choosen)

" Spellcheking
highlight SpellBad term=underline gui=undercurl

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Color schemes {{{
function! Light_background ()
    set background=light
    if g:os == "osx"
        colorscheme macvim
    else
        colorscheme default
        hi CursorLine cterm=none ctermbg=lightgrey
    endif
    highlight iCursor guifg=black guibg=black
endfunction

function! Dark_background ()
    set background=dark
    "colorscheme molokai
    let g:badwolf_html_link_underline = 0
    let g:badwolf_css_props_highlight = 1
    "colorscheme badwolf
    colorscheme molokai
    highlight iCursor guifg=red guibg=red
endfunction

nnoremap <leader>D :call Dark_background()<cr>
nnoremap <leader>L :call Light_background()<cr>

" Default
if has('gui_running')
    "call Light_background()
    call Dark_background()
else
    call Dark_background()
endif

" }}}

" }}}
" Omnicomplete ------------------------------------------------------------ {{{

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" }}}
" Fucking hacks ----------------------------------------------------------- {{{

" Fix this fucking keyboard
imap § >
imap ± <

" Automatic brackets completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

" }}}
" Plugins ----------------------------------------------------------------- {{{

" Command-T {{{

nnoremap <leader>t :CommandT<CR>

" }}}
" Gundo {{{

nnoremap <leader>@ :GundoToggle<CR>
nnoremap <F14> :GundoToggle<CR>

" }}}
" Nerd Tree {{{

nnoremap <leader>& :NERDTreeToggle<cr>
nnoremap <F13> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']
au Filetype nerdtree setlocal nolist
let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" }}}
" Powerline {{{
if has('gui_running') || g:os == "osx"
    let g:Powerline_symbols = 'fancy'
else
    let g:Powerline_symbols = 'compatible'
end
" }}}
" Rainbow Parentheses {{{

nnoremap <leader>R :RainbowParenthesesToggle<cr>
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16

" Uncomment to get Rainbow Parentheses loaded on Vim start
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

" }}}
" Scratch {{{

nnoremap <leader><tab> :ScratchToggle<CR>
inoremap <leader><tab> <Esc>:ScratchToggle<CR>i

" }}}
" Yankring {{{

nnoremap <leader>- :YRShow<CR>
nnoremap <f15> :YRShow<CR>
let yankring_history_dir='~/.vim/tmp'

" }}}

" }}}
" File type-specific configuration ---------------------------------------- {{{

" Clojure {{{

let vimclojureRoot = "~/.vim/bundle/vimclojure"
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1

" }}}
" Go {{{

autocmd FileType go setlocal smartindent
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4
autocmd FileType go setlocal tw=0

" }}}
" Haskell {{{

augroup ft_haskell
    au!
    au BufEnter *.hs compiler ghc
augroup END

" }}}
" HTML {{{

autocmd FileType html set ft=htmldjango.html " For SnipMate

" }}}
" Javascript {{{
autocmd FileType javascript set tw=80 
" }}}
" Mercurial {{{

augroup ft_mercurial
    au!

    au BufNewFile,BufRead *hg-editor-*.txt setlocal filetype=hgcommit
augroup END

" }}}
" Puppet {{{

" Add Puppet file highlighting 
au BufRead,BufNewFile *.pp setfiletype puppet

" }}}
" Python {{{

autocmd FileType python set ft=python.django " For SnipMate

" }}}
" TeX {{{

" Correct .tex file handling
let g:tex_flavor='latex'

" }}}
" Vagrant {{{

" Add Vagrant file highlighting
au BufNewFile,BufRead Vagrantfile set filetype=ruby

" }}}

" }}}
" GUI-specific configuration ---------------------------------------------- {{{

if has('gui_running')
    set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    set guicursor+=i-ci:ver20-iCursor-blinkwait10-blinkon500-blinkoff300
endif

" }}}
