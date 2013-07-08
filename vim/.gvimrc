" Font face
if g:os == 'linux'
    set guifont=Menlo\ for\ Powerline\ 10
elseif g:os == 'osx'
    set guifont=Menlo\ for\ Powerline:h12
end


let g:Powerline_symbols = 'fancy'

" Syntax color scheme
highlight SpellBad term=underline gui=undercurl guisp=Orange

" Remove useless stuff (toolbar, scrollers and so on)
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

if g:os == 'linux'
    set guioptions-=m
end

" Set the same leader as in .vimrc
let mapleader = ","

" Full-screen editing
nnoremap <leader>f :set invfu<CR>
