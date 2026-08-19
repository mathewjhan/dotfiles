"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" -------------
" PLUGINS BELOW
" -------------
" Random
Plug 'dstein64/vim-startuptime'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc'

" UI/UX
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'mkitt/tabline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'julian/vim-textobj-variable-segment'
Plug 'kana/vim-textobj-user'
Plug 'timakro/vim-yadi'

" Devtools
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'sbdchd/neoformat'
Plug 'machakann/vim-sandwich'

" Themes
" Normal
Plug 'sainnhe/sonokai'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }

" Auto pairs (nvim uses nvim-autopairs, managed by lazy.nvim)
if !has('nvim')
  Plug 'cohama/lexima.vim'
endif

call plug#end()

" Autoinstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif


let mapleader = ","
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => yadi
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Try to auto detect and use the indentation of a file when opened. 
autocmd BufRead * DetectIndent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>fz :Files<cr>
nnoremap <silent> <leader>rg :Rg<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE

set termguicolors
if !has('nvim')
  colorscheme embark
endif

"" tmux navigator
let g:tmux_navigator_no_wrap = 1
