let mapleader=" "

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
set updatetime=300 "autocomplete update
set timeoutlen=200 "change speed of input timeout in normal mode

"centre cursor
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=99999
augroup END

if has('persistent_undo')                       "check if your vim version supports it
  set undofile                                  "turn on the feature
  set undodir=$HOME/.config/nvim/histfiles      "directory where the undo files will be stored
endif

"stop auto comment next line on enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"install vim plug
if empty(glob('~/.config/nvim/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.config/nvim/.vim/plug --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

so ~/.config/nvim/.vim/autoload/plug.vim

call plug#begin('~/.config/nvim/.vim/plugged') "set plugin dir

Plug 'vim-airline/vim-airline'
let g:airline_section_z = "%#__accent_bold#%l%#__restore__#%#__accent_bold#/%L%#__restore__# %v"

Plug 'wesQ3/vim-windowswap'

Plug 'cohama/lexima.vim' "close parens

Plug 'preservim/nerdtree'
"open nerdtree on empty buffers
if !exists('g:started_by_firenvim')
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
endif

"autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
so ~/.config/nvim/CoC.vim
"change coc colours
hi CocFloating ctermbg=black
"coc spelling
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

Plug 'sheerun/vim-polyglot' "lots of syntax highlighting

Plug 'mbbill/undotree'

Plug 'tpope/vim-fugitive' "git commands

Plug 'jeetsukumaran/vim-indentwise' "move by indent

Plug 'thaerkh/vim-indentguides' "indentguides
let g:indentguides_ignorelist = ['text']
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '|'

Plug 'dylanaraps/wal.vim' "pywal colours

Plug 'rust-lang/rust.vim' "rust syntax

Plug 'preservim/nerdcommenter' "comment lines

"optional color previews, i do not use as would require termguicolors which messes with my wal colorscheme
"Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "show colours
"set termguicolors
"let g:Hexokinase_highlighters = ['backgroundfull']
"let g:Hexokinase_refreshEvents = ['InsertLeave']

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

"change tab colours
hi TabLine cterm=NONE ctermbg=0 ctermfg=4
hi TabLineFill ctermbg=4 ctermfg=0
hi TabLineSel ctermbg=NONE ctermfg=8

"this needs to be at the bottom
colorscheme wal
hi CursorLine cterm=NONE
set cmdheight=1 "merge text and cmd at bottom

so ~/.config/nvim/maps.vim "maps
