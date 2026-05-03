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

if has('nvim')
  Plug 'sainnhe/everforest'
endif

" Auto pairs
if has('nvim')
  Plug 'windwp/nvim-autopairs'
else
  Plug 'cohama/lexima.vim'
endif

" NVIM plugins
if has('nvim')
  " LSP
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'honza/vim-snippets'
  Plug 'dcampos/nvim-snippy'
  Plug 'dcampos/cmp-snippy'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'williamboman/mason.nvim'
  
  " Random
  Plug 'm4xshen/hardtime.nvim'
  Plug 'xeluxee/competitest.nvim'
  Plug 'kawre/leetcode.nvim'

  " Devtools/git
  Plug 'sindrets/diffview.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'natecraddock/workspaces.nvim'
  Plug 'smjonas/inc-rename.nvim'
  Plug 'error311/wayfinder.nvim'
  Plug 'ibhagwan/fzf-lua'
  
  " UI/UX
  Plug 'nvim-mini/mini.nvim', { 'branch': 'stable' }
  Plug 'kevinhwang91/nvim-ufo'
  Plug 'kevinhwang91/promise-async'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'shortcuts/no-neck-pain.nvim'
  Plug 'MunifTanjim/nui.nvim'
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
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" On window resize, if goyo is active, do <c-w>= to resize the window
autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
let g:goyo_width = 100
nnoremap <silent> <leader>g :Goyo<cr>
autocmd! User GoyoEnter nested :set nu! rnu!
autocmd! User GoyoEnter nested :set norelativenumber
autocmd! User GoyoLeave nested :set relativenumber!
autocmd! User GoyoLeave nested :set number!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-t> :TagbarToggle<CR>

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
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>rg :Rg<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Floaterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>fm :FloatermNew ranger<cr>
nnoremap <leader>lg :FloatermNew lazygit<cr>
let g:floaterm_keymap_new = '<leader>ft'
autocmd VimResized * FloatermUpdate

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE

set termguicolors
if has('nvim')
  colorscheme everforest
else
  colorscheme embark
endif

"" tmux navigator
let g:tmux_navigator_no_wrap = 1
