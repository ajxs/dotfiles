" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" General plugins.
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/limelight.vim'
Plug 'ap/vim-buftabline'
Plug 'schickling/vim-bufonly'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Colorschemes
Plug 'jnurmine/Zenburn'
Plug 'seesleestak/duo-mini'
Plug 'junegunn/seoul256.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'sainnhe/vim-color-forest-night'
Plug 'KKPMW/sacredforest-vim'
Plug 'sts10/vim-pink-moon'
Plug 'tomasiser/vim-code-dark'
Plug 'romainl/Apprentice'

call plug#end()

" Set up line number display.
set nu
set relativenumber

filetype plugin indent on
set autoindent
set laststatus=2
set tabstop=2
set showmatch
set cmdheight=1

" GUI config.
set guifont=Inconsolata
set linespace=-1
set guioptions -=T

" Configure syntax.
syntax enable
syntax on

" Limelight
let g:limelight_paragraph_span = 3
autocmd VimEnter * Limelight

set noshowmode
set laststatus=2

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
au BufRead,BufEnter /home/$USER/cxos/*.S set noet shiftwidth=2 ts=2
augroup END

nnoremap <F5> :buffers<CR>:buffer<Space>
noremap  <F6> :set list!<CR>
inoremap <F6> <C-o>:set list!<CR>
cnoremap <F6> <C-c>:set list!<CR>
nmap <C-H> :bprev<CR>
nmap <C-L> :bnext<CR>
nmap ' :Bonly<CR>
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
