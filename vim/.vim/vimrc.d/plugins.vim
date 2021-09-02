"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" -------------
" PLUGINS BELOW
" -------------

" Github
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'sbdchd/neoformat'
Plug 'SirVer/ultisnips'
Plug 'mkitt/tabline.vim'
Plug 'lervag/vimtex'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'godlygeek/tabular'
Plug 'dylanaraps/wal.vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tmsvg/pear-tree'
Plug 'scrooloose/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'machakann/vim-sandwich'
Plug 'Yggdroot/indentLine'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

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


let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pandoc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable spell-check as defauult
let g:pandoc#spell#enabled = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown & TeX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Zathura previews
let g:vimtex_view_method="zathura"
let g:tex_flavor = 'latex'
let g:pandoc#syntax#conceal#use = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>f :FZF<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-space>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim (backup)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" Snippets functionality

" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ coc#refresh()
" 
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" let g:coc_snippet_next = '<tab>'

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

