setlocal shiftwidth=2
setlocal tabstop=2

let mapleader = ","

nnoremap <leader>c :! pdflatex %<cr>
nnoremap <leader>C :! pdflatex %<cr> :! bibtex %:t:r.aux<cr> :! pdflatex %<cr> :! pdflatex %<cr>
nnoremap <leader>a :! open %:t:r.pdf<cr>

nnoremap <leader>t :w !detex \| wc -w<cr>
nnoremap <leader>E :! rm *.aux *.log<cr>
