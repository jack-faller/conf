"splits
nnoremap <silent> <C-J> <C-W><C-J>
nnoremap <silent> <C-K> <C-W><C-K>
nnoremap <silent> <C-L> <C-W><C-L>
nnoremap <silent> <C-H> <C-W><C-H>
nnoremap <silent> <C-Up> <C-W>+
nnoremap <silent> <C-Down> <C-W>-
nnoremap <silent> <C-Left> <C-W><
nnoremap <silent> <C-Right> <C-W>>
nnoremap <silent> <Up> :split<CR>
nnoremap <silent> <Down> :below split<CR>
nnoremap <silent> <Left> :vsplit<CR>
nnoremap <silent> <Right> :below vsplit<CR>

"move indent wise
map <silent> <M-h> <Plug>(IndentWisePreviousLesserIndent)zz
map <silent> <M-H> <Plug>(IndentWiseNextLesserIndent)zz
map <silent> <M-j> <Plug>(IndentWiseNextEqualIndent)zz
map <silent> <M-J> <Plug>(IndentWiseBlockScopeBoundaryEnd)zz
map <silent> <M-k> <Plug>(IndentWisePreviousEqualIndent)zz
map <silent> <M-K> <Plug>(IndentWiseBlockScopeBoundaryBegin)zz
map <silent> <M-l> <Plug>(IndentWiseNextGreaterIndent)zz
map <silent> <M-L> <Plug>(IndentWisePreviousGreaterIndent)zz
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
"these are here just to make it concistant
inoremap <A-K> <C-Up>
inoremap <A-J> <C-Down>

"hide numbers
noremap <silent> <Leader>n :set nonumber<CR>:set norelativenumber<CR>:set signcolumn=no<CR>
noremap <silent> <Leader>nn :set number<CR>:set relativenumber<CR>:set signcolumn=yes<CR>

"windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>w :call WindowSwap#EasyWindowSwap()<CR>
noremap <silent> <C-q> :q<CR>

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

autocmd FileType rust noremap <F5> :wa <bar> :Cargo run <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G
autocmd FileType rust noremap <F6> :wa <bar> :Cargo build <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G
autocmd FileType rust noremap <F8> :RustFmt<CR>

autocmd FileType rust noremap! <F5> <Esc>:wa <bar> :Cargo run <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G
autocmd FileType rust noremap! <F6> <Esc>:wa <bar> :Cargo build <CR>:nnoremap <buffer> <C-v><Esc> :q<C-v><CR><CR>G
autocmd FileType rust noremap! <F8> <Esc>:RustFmt<CR>

autocmd FileType rust inoremap <silent> \<Space> <Esc>:let prev_hist=@/<CR>/jmptag<CR>:let @/=prev_hist<CR>:noh<Enter>2h"_c10l
autocmd FileType rust inoremap <silent> <Esc> <Esc>:let prev_hist=@/<CR>mZ:%s#]/\*jmptag\*/##ge<CR>:%s#\n^\s*}/\*jmptag\*/##ge<CR>:%s#)/\*jmptag\*/##ge<CR>`Z:%s#/\*jmptag\*/##ge<Enter>:let @/=prev_hist<CR>
autocmd FileType rust inoremap <silent> \\ \
autocmd FileType rust inoremap <silent> {} {}
autocmd FileType rust inoremap <silent> () ()
autocmd FileType rust inoremap <silent> [] []
autocmd FileType rust inoremap <silent> { {<CR>}/*jmptag*/<Esc>kA
autocmd FileType rust inoremap <silent> ( ()/*jmptag*/<Esc>?(<Enter>:noh<Enter>a
autocmd FileType rust inoremap <silent> [ []/*jmptag*/<Esc>?[<Enter>:noh<Enter>a
autocmd FileType rust inoremap <silent> \m let<Space>mut<Space><Esc>mZa<Space>=<Space>/*jmptag*/;/*jmptag*/<Esc>`Za
autocmd FileType rust inoremap <silent> \n let<Space><Esc>mZa<Space>=<Space>/*jmptag*/;/*jmptag*/<Esc>`Za
autocmd FileType rust inoremap <silent> \i if<Space><Esc>mZa<Space>{
autocmd FileType rust inoremap <silent> \w while<Space><Esc>mZa<Space>{<Enter>/*jmptag*/<Enter>}/*jmptag*/<Esc>`Za
autocmd FileType rust inoremap <silent> \f for<Space><Esc>mZa<Space>in<Space>/*jmptag*/<Space>{<Enter>/*jmptag*/<Enter>}/*jmptag*/<Esc>`Za
autocmd FileType rust inoremap <silent> \l loop<Space>{<Enter>/*jmptag*/<Enter>}/*jmptag*/<Esc>`Za
autocmd FileType rust imap <silent> \e else{
autocmd FileType rust inoremap <silent> \p println!("<Esc>mZa",<Space>/*jmptag*/);/*jmptag*/<Esc>`Za
autocmd FileType rust inoremap <silent> \o <Esc>Iprintln!("{:#?}",<Space><Esc>A);
autocmd FileType rust inoremap <silent> \t #[test]<Enter>
autocmd FileType rust inoremap <silent> \d <Esc>mZ:let prev_hist=@/<CR>:%s#/\*jmptag\*/##ge<Enter>:let @/=prev_hist<CR>`Za

autocmd BufNewFile,BufRead Xresources noremap <F8> :w<CR>:!xrdb "$HOME/.config/Xresources"<CR><CR>
autocmd BufNewFile,BufRead Xresources noremap! <F8> <CR>:w<CR>:!xrdb "$HOME/.config/Xresources"<CR><CR>
