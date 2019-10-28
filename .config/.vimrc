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

call plug#end()

" Set up line number display.
set nu

set autoindent
set laststatus=2
set tabstop=2

" Configure colorscheme.
colorscheme seoul256

" Configure syntax.
syntax enable
syntax on
set colorcolumn=100

set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

augroup ProjectSetup
au BufRead,BufEnter /home/$USER/cxos/*.S set et shiftwidth=2 ts=2
augroup END
