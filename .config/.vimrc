" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" General plugins.
Plug 'Quramy/tsuquyomi'
Plug 'Raimondi/delimitMate'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'

" Colorschemes
Plug 'jnurmine/Zenburn'
Plug 'seesleestak/duo-mini'
Plug 'davidosomething/vim-colors-meh'
Plug 'junegunn/seoul256.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Plug 'gosukiwi/vim-atom-dark'
" Plug 'jnurmine/Zenburn'
" Plug 'sansbrina/vim-garbage-oracle'
" Plug 'neutaaaaan/monosvkem'
" Plug 'sts10/vim-pink-moon'
" Plug 'vim-scripts/oceanlight'
" Plug 'phanviet/sidonia'

call plug#end()

" Set up line number display.
set nu
set relativenumber

set autoindent
set laststatus=2
set tabstop=2
set showmatch
set cmdheight=1

" Configure syntax.
syntax enable
syntax on

" Configure colorscheme.
set colorcolumn=100
" set termguicolors
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

:nnoremap <F5> :buffers<CR>:buffer<Space>
