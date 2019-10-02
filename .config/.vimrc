" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" General plugins.
Plug 'Quramy/tsuquyomi'
Plug 'Raimondi/delimitMate'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'

" Colorschemes
Plug 'jnurmine/Zenburn'
Plug 'seesleestak/duo-mini'
Plug 'davidosomething/vim-colors-meh'
Plug 'junegunn/seoul256.vim'

call plug#end()

" Set up line number display.
set nu

" Set up indentation.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2

" Configure colorscheme.
colorscheme duo-mini

" Configure syntax.
syntax enable
syntax on
set colorcolumn=100

set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
