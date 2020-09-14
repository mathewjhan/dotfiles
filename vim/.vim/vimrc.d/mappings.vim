"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
" nmap <leader>q :q!<cr>
nmap <leader>q :q!<cr>

" Fast save and quit
nmap <leader>z :wq<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Moving around, tabs, windows and buffers

" Count movement for j,k
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Map <Esc> in term mode to exit term
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>

" Map <leader>n to toggle line numbers
nmap <leader>n :set nu!<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Editing mappings
" Remap VIM 0 to first non-blank character
map 0 ^

" Spell checking
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

" New lines in normal mode, works with numbers
nn <silent> <leader>o :<c-u>let b:_=getcurpos()<bar>put!=repeat(nr2char(10), v:count1)<bar>let b:_[1]+=v:count1<bar>call setpos('.', b:_)<bar>unlet b:_<cr>
nn <silent> <leader>O :<c-u>let b:_=getcurpos()<bar>put=repeat(nr2char(10), v:count1)<bar>call setpos('.', b:_)<bar>unlet b:_<cr>

" Visual selection helper function
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


