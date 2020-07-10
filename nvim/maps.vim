"splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Up> <C-W>+
nnoremap <C-Down> <C-W>-
nnoremap <C-Left> <C-W><
nnoremap <C-Right> <C-W>>
nnoremap <Up> :split<CR>
nnoremap <Down> :below split<CR>
nnoremap <Left> :vsplit<CR>
nnoremap <Right> :below vsplit<CR>

"mappings
map <Leader>n :set nonumber<CR>:set norelativenumber<CR>:set signcolumn=no<CR>
map <Leader>nn :set number<CR>:set relativenumber<CR>:set signcolumn=yes<CR>
map <M-]> :n<CR>
map <M-[> :prev<CR>
map <M-h> <Plug>(IndentWisePreviousLesserIndent)zz
map <M-H> <Plug>(IndentWiseNextLesserIndent)zz
map <M-j> <Plug>(IndentWiseNextEqualIndent)zz
map <M-J> <Plug>(IndentWiseBlockScopeBoundaryEnd)zz
map <M-k> <Plug>(IndentWisePreviousEqualIndent)zz
map <M-K> <Plug>(IndentWiseBlockScopeBoundaryBegin)zz
map <M-l> <Plug>(IndentWiseNextGreaterIndent)zz
map <M-L> <Plug>(IndentWisePreviousGreaterIndent)zz

autocmd FileType rust map <F5> :wa <bar> :!cargo run <CR>
autocmd FileType rust map <F6> :wa <bar> :!cargo build <CR>
autocmd FileType rust map <F8> :RustFmt<CR>
map <F7> :wqa <CR>
map <F3> :BLines <CR>
nnoremap <M-u> :UndotreeToggle<cr>
nnoremap <F2> :NERDTreeToggle<cr>
nnoremap S :%s//g<Left><Left>

autocmd FileType rust map! <F5> <Esc>:wa <bar> :!cargo run <CR>
autocmd FileType rust map! <F6> <Esc>:wa <bar> :!cargo build <CR>
autocmd FileType rust map! <F8> <Esc>:RustFmt<CR>
map! <F7> <Esc>:wqa <CR>
map! <F3> <Esc>:BLines <CR>

autocmd FileType rust inoremap \<Space> <Esc>/jmptag<Enter>:noh<Enter>2h"_c10l
autocmd FileType rust inoremap {} {}
autocmd FileType rust inoremap () ()
autocmd FileType rust inoremap [] []
autocmd FileType rust inoremap { {<CR>}/*jmptag*/<Esc>kA
autocmd FileType rust inoremap ( ()/*jmptag*/<Esc>?(<Enter>:noh<Enter>a
autocmd FileType rust inoremap [ []/*jmptag*/<Esc>?[<Enter>:noh<Enter>a
autocmd FileType rust inoremap <silent> <Esc> <Esc>mZ:%s#]/\*jmptag\*/##ge<CR>:%s#\n^\s*}/\*jmptag\*/##ge<CR>:%s#)/\*jmptag\*/##ge<CR>`Z:delm Z<CR>:%s#/\*jmptag\*/##ge<Enter>
autocmd FileType rust inoremap <silent> \m let<Space>mut<Space><Esc>mZa<Space>=<Space>/*jmptag*/;<Enter>/*jmptag*/<Esc>`Z:delm Z<CR>a
autocmd FileType rust inoremap <silent> \n let<Space><Esc>mZa<Space>=<Space>/*jmptag*/;<Enter>/*jmptag*/<Esc>`Z:delm Z<CR>a
autocmd FileType rust inoremap <silent> \i if<Space><Esc>mZa<Space>{
autocmd FileType rust inoremap <silent> \w while<Space><Esc>mZa<Space>{<Enter>/*jmptag*/<Enter>}<Enter>/*jmptag*/<Esc>`Z:delm Z<CR>a
autocmd FileType rust inoremap <silent> \f for<Space><Esc>mZa<Space>in<Space>/*jmptag*/<Space>{<Enter>/*jmptag*/<Enter>}<Enter>/*jmptag*/<Esc>`Z:delm Z<CR>a
autocmd FileType rust inoremap <silent> \l loop<Space>{<Enter>/*jmptag*/<Enter>}<Enter>/*jmptag*/<Esc>`Z:delm Z<CR>a
autocmd FileType rust imap <silent> \e else{
autocmd FileType rust inoremap <silent> \p println!("<Esc>mZa",<Space>/*jmptag*/);<Enter>/*jmptag*/<Esc>`Z:delm Z<CR>a
autocmd FileType rust inoremap <silent> \o <Esc>Iprintln!("{:#?}",<Space><Esc>A);
autocmd FileType rust imap <silent> \t #[test]<Enter>
autocmd FileType rust noremap <silent> \d :%s#/\*jmptag\*/##ge<Enter>

autocmd BufNewFile,BufRead Xresources map <F8> :w<CR>:!xrdb "/home/jack/.config/Xresources"<CR><CR>
autocmd BufNewFile,BufRead Xresources map! <F8> <CR>:w<CR>:!xrdb "/home/jack/.config/Xresources"<CR><CR>
