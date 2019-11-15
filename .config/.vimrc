" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" General plugins.
" Plug 'Quramy/tsuquyomi'
" Plug 'leafgarland/typescript-vim'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/limelight.vim'

" Colorschemes
Plug 'jnurmine/Zenburn'
Plug 'seesleestak/duo-mini'
Plug 'davidosomething/vim-colors-meh'
Plug 'junegunn/seoul256.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'sansbrina/vim-garbage-oracle', { 'branch': 'release' }
Plug 'sainnhe/vim-color-forest-night'
Plug 'KKPMW/sacredforest-vim'
Plug 'sts10/vim-pink-moon'
Plug 'tomasiser/vim-code-dark'


call plug#end()

" Set up line number display.
set nu
set relativenumber

set autoindent
set laststatus=2
set tabstop=2
set showmatch
set cmdheight=1

" GUI config.
set guifont=Inconsolata
set tb=
set linespace=-1

" Configure syntax.
syntax enable
syntax on

" Limelight
let g:limelight_paragraph_span = 3
autocmd VimEnter * Limelight

" Airline
let g:airline#extensions#tabline#enabled = 1

" Configure colorscheme.
set colorcolumn=90
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
colorscheme seoul256

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

augroup ProjectSetup
au BufRead,BufEnter /home/$USER/cxos/*.S set et shiftwidth=2 ts=2
augroup END

nnoremap <F5> :buffers<CR>:buffer<Space>
noremap <F6> :set list!<CR>
inoremap <F6> <C-o>:set list!<CR>
cnoremap <F6> <C-c>:set list!<CR>
nmap <C-H> :bprev<CR>
nmap <C-L> :bnext<CR>
