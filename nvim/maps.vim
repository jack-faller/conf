"make Y consistent with D and C
nnoremap Y y$
"paste from paste register
noremap <M-p> "0p
noremap <M-P> "0P
"clipboard wayland
noremap <leader>gc :call  system("wl-copy --trim-newline", @")<CR>

inoremap {<CR> {<CR>}<ESC>O
inoremap {; {<CR>};<ESC>O

"splits
nnoremap <silent> <C-J>     <C-W><C-J>
nnoremap <silent> <C-K>     <C-W><C-K>
nnoremap <silent> <C-L>     <C-W><C-L>
nnoremap <silent> <C-H>     <C-W><C-H>
nnoremap <silent> <S-Up>    <C-W>+
nnoremap <silent> <S-Down>  <C-W>-
nnoremap <silent> <S-Left>  <C-W><
nnoremap <silent> <S-Right> <C-W>>
nnoremap <silent> <Up>      :split<CR>
nnoremap <silent> <Down>    :below split<CR>
nnoremap <silent> <Left>    :vsplit<CR>
nnoremap <silent> <Right>   :below vsplit<CR>

"move
noremap <M-e> ge
noremap <M-E> gE

"move indent wise
map <silent> <M-h> <Plug>(IndentWisePreviousLesserIndent)
map <silent> <M-j> <Plug>(IndentWiseNextEqualIndent)
map <silent> <M-k> <Plug>(IndentWisePreviousEqualIndent)
map <silent> <M-l> <Plug>(IndentWiseNextGreaterIndent)

map <silent> <C-M-h> <Plug>(IndentWiseNextLesserIndent)
map <silent> <C-M-j> <Plug>(IndentWiseBlockScopeBoundaryEnd)
map <silent> <C-M-k> <Plug>(IndentWiseBlockScopeBoundaryBegin)
map <silent> <C-M-l> <Plug>(IndentWisePreviousGreaterIndent)

"move files
noremap <silent> <M-]> :n<CR>
noremap <silent> <M-[> :prev<CR>

"move in insert mode
inoremap <A-k> <Up>
inoremap <A-j> <Down>
inoremap <A-h> <Left>
inoremap <A-l> <Right>
"do so wordwise
inoremap <A-H> <C-Left>
inoremap <A-L> <C-Right>
"these are here just to make it consistent
inoremap <A-K> <C-Up>
inoremap <A-J> <C-Down>
"delete
inoremap <C-l> <Del>
"<C-BS> to delete word
inoremap  

"escape tab complete
inoremap <A-t> <tab>

"toggle hlsearch
nnoremap <silent> <leader>th :set hls!<CR>

"toggle numbers
noremap <silent> <leader>tn :set number!<CR>:set relativenumber!<CR>

"toggle sign column
noremap <silent> <leader>ts :if (&scl == "yes") \| set scl=no \| else \| set scl=yes \| endif<CR>

"toggle indent guides
nnoremap <silent> <leader>ti :IndentGuidesToggle<CR>

"windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>w :call WindowSwap#EasyWindowSwap()<CR>
noremap <silent> <C-q> :q<CR>

"quit terminal insert
tnoremap <C-q> <C-\><C-n>:q<CR>

"better cmd line
nnoremap <silent> : q::let b:coc_suggest_disable = 1<CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>i
nnoremap <silent> <M-:> :
nnoremap <silent> <M-/> q/:let b:coc_suggest_disable = 1<CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>i
nnoremap <silent> <M-?> q?:let b:coc_suggest_disable = 1<CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>i
nmap S :%s//g<Left><Left>

nnoremap <M-u> :UndotreeToggle<cr>
nnoremap <F2> :NERDTreeToggle<cr>

noremap <F3> :BLines <CR>
noremap! <F3> <Esc>:BLines <CR>

noremap <F7> :wqa <CR>
noremap! <F7> <Esc>:wqa <CR>

noremap <silent> <F8> :Neoformat<CR>
noremap! <silent> <F8> <Esc>:Neoformat<CR>

"integrate git
nnoremap <silent> <leader>Gc :G commit -m ""<Left>
nnoremap <silent> <leader>Ga :w<cr>:G add %<cr>
nnoremap <leader>Gs :G status<cr>

autocmd FileType cpp inoremap <silent> <Home> <Esc>Istd::cout << <esc>A << '\n';
autocmd FileType cpp inoremap <silent> <S-Home> <Esc>_v$:s/,/ << ' ' << /g<CR>Istd::cout << <esc>A << '\n';

"c#
autocmd FileType cs noremap  <F6>     :w<CR>:sp :terminal dotnet build<CR>
autocmd FileType cs inoremap <F6>     <esc>:w<CR>:sp :terminal dotnet build<CR>
autocmd FileType cs noremap  <silent> <F5> :w<CR>:sp :terminal dotnet run<CR><CR>
autocmd FileType cs inoremap <silent> <F5> <esc>:w<CR>:sp :terminal dotnet run<CR><CR>
autocmd FileType cs inoremap <silent> <Home> <Esc>IConsole.WriteLine(<Esc>A.ToString());

autocmd FileType rust noremap <F5> :wa <bar> :sp<CR>:terminal cargo run <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G
autocmd FileType rust noremap <F6> :wa <bar> :sp<CR>:terminal cargo build <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G

autocmd FileType rust noremap! <F5> <Esc>:wa <bar> :sp<CR>:terminal cargo run <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G
autocmd FileType rust noremap! <F6> <Esc>:wa <bar> :sp<CR>:terminal cargo build <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G

autocmd FileType rust inoremap <silent> <Home> <Esc>Idbg!(&<Esc>A);

autocmd FileType lisp nnoremap <silent> \\ :sb [Command Line]<CR>
