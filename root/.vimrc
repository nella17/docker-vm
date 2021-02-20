" for pane moving
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" short custom config
set nocp nu rnu cul noswf sc nosmd
"set mouse=a
au WinEnter * setl cul
au WinLeave * setl nocul
set sb spr stal=2 ru
set cb=unnamed
set ts=2 sw=2 sts=2 et
set ai cin si sta
set hls sm is ic scs
set ls=2 so=5
set enc=utf-8 ff=unix
set wrap lbr
" set viminfo='0,:0,<0,@0,f0
set viminfo="NONE"
filetype plugin indent on

syntax enable
colo torte
set bg=dark
hi Normal guibg=NONE ctermbg=NONE

filetype indent plugin on
# au BufRead,BufWritePre * if &modifiable | %retab!
# au InsertLeave,BufWritePre * %s/\s\+$//e

"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"set list

au Filetype c,cpp setlocal ts=4 sw=4 sts=4 et
au Filetype javascript setlocal ts=2 sw=2 sts=2 et
au Filetype python setlocal ts=4 sw=4 sts=4 et

au Filetype python noremap <F5> :% w !python<CR>
au Filetype python inoremap <F5> <ESC>:% w !python<CR>
au BufRead,BufNewFile *.sage set filetype=python

au Filetype cpp noremap <F9> :w<CR>:!run_c '%'<CR>
au Filetype cpp inoremap <F9> <ESC>:w<CR>:!run_c '%'<CR>

au Filetype javascript noremap <F5> :% w !node<CR>
au Filetype javascript inoremap <F5> <ESC>:% w !node<CR>

au Filetype sh noremap <F5> :% w !bash<CR>
au Filetype sh inoremap <F5> <ESC>:% w !bash<CR>

noremap ; :
