let mapleader=" "

filetype plugin indent on "activates file type detection

syntax on "activates syntax highlighting among other things

set path+=** wildmenu "allow fuzzy find with complete
set number relativenumber "set the side numbers
set hidden " allows you to deal with multiple unsaved buffers simultaneously without resorting to misusing tabs
set backspace=indent,eol,start " just hit backspace without this one and see for yourself
set nocompatible "no longer emulate vi
set wildmode=longest,list,full "other auto-complete
set tabstop=4 shiftwidth=4 smarttab expandtab autoindent smartindent "change tabs to 4 spaces
set noshowmode "don't show mode at bottom e.g. --INSERT--
set updatetime=300 "auto-complete update
set timeoutlen=1500 "change speed of input timeout in normal mode
set spell spelllang=en_gb

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

Plug 'sbdchd/neoformat'
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-surround' "delete surrounding
Plug 'cohama/lexima.vim' "close parens
Plug 'preservim/nerdtree'
"open nerd tree on empty buffers
if !exists('g:started_by_firenvim')
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
endif

"auto-complete
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
function Gac(msg)
    :G add %
    :G commit -m msg
:endfunction

Plug 'jeetsukumaran/vim-indentwise' "move by indent

Plug 'thaerkh/vim-indentguides' "indent guides
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
