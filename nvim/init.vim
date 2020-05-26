"in vim run :PlugInstall

let mapleader = " "

colorscheme delek

filetype plugin indent on "activates filetype detection

syntax on "activates syntax highlighting among other things

set path+=** wildmenu "allow fuzzyfind with complete
set number relativenumber "set the side numbers
set hidden " allows you to deal with multiple unsaved buffers simultaneously without resorting to misusing tabs
set backspace=indent,eol,start " just hit backspace without this one and see for yourself
set nocompatible "no longer emulate vi
set wildmode=longest,list,full "other autocomplete
set smarttab expandtab autoindent smartindent "change tabs to spaces infer no spaces
set noshowmode "don't show mode at bottom eg --INSERT--
set updatetime=300 timeoutlen=100 "autocomplete update

"stop auto comment next line on enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

call plug#begin('~/.config/nvim/.vim/plugged') "set plugin dir

Plug 'vim-airline/vim-airline'

"autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
so ~/.config/nvim/CoC.vim

Plug 'jeetsukumaran/vim-indentwise' "move by indent

Plug 'dylanaraps/wal.vim' "pywal colours

Plug 'rust-lang/rust.vim' "rust syntax

Plug 'preservim/nerdcommenter' "comment lines

"Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "show colours

Plug 'junegunn/vim-slash' "highlight while searching

"find fuzzies
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end() "init plugins

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

"deal with other colour previews
"set termguicolors
"let g:Hexokinase_highlighters = ['backgroundfull']
"let g:Hexokinase_refreshEvents = ['InsertLeave']

"file edit
let g:netrw_banner = 0
let g:netrw_browse_split = 1

colorscheme wal
"change tab colours
hi TabLine cterm=NONE ctermbg=0 ctermfg=4
hi TabLineFill ctermbg=4 ctermfg=0
hi TabLineSel ctermbg=NONE ctermfg=8
"change coc colours
hi CocFloating ctermbg=black

set cmdheight=1 "merge text and cmd at bottom

so ~/.config/nvim/maps.vim "maps
