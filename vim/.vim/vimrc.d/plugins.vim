"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" -------------
" PLUGINS BELOW
" -------------

" Github
Plug 'conornewton/vim-pandoc-markdown-preview'
Plug 'lervag/vimtex'
Plug 'skywind3000/asyncrun.vim'
Plug '907th/vim-auto-save'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'godlygeek/tabular'
Plug 'dylanaraps/wal.vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-surround'
Plug 'tmsvg/pear-tree'
Plug 'scrooloose/nerdcommenter'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'psliwka/vim-smoothie'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" Local
Plug 'file://'.expand('~/.vim/local/vpmp-togglable')

" BACKUP AUTOCOMPLETER
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" 
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1
"

call plug#end()

" Autoinstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pandoc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable spell-check as defauult
let g:pandoc#spell#enabled = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown & TeX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Zathura previews
let g:md_pdf_viewer="zathura"
let g:vimtex_view_method="zathura"
let g:tex_flavor = 'latex'
let g:pandoc#syntax#conceal#use = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Deoplete (backup)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" call deoplete#custom#option('sources', {
"     \ 'java': ['LanguageClient'],
"     \ })
" 
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Server Protocol 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:LanguageClient_serverCommands = {
"     \ 'java'   : ['jdtls'],
"     \ 'cpp'    : ['ccls'],
"     \ 'python' : ['pyls'],
"    \ }

