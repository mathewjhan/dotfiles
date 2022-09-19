"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" -------------
" PLUGINS BELOW
" -------------

" Github
Plug 'anufrievroman/vim-angry-reviewer'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'cohama/lexima.vim'
Plug 'dstein64/vim-startuptime'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'lervag/vimtex'
Plug 'machakann/vim-sandwich'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mkitt/tabline.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'preservim/tagbar'
Plug 'sbdchd/neoformat'
Plug 'skywind3000/asyncrun.vim'
Plug 'timakro/vim-yadi'
Plug 'vim-airline/vim-airline'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'kana/vim-textobj-user'
Plug 'julian/vim-textobj-variable-segment'

if has('python3') && has('timers')
  Plug 'danth/pathfinder.vim'
else
  echoerr 'pathfinder.vim is not supported on this Vim installation'
endif

" Themes
" Normal
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
" Wal
Plug 'nekonako/xresources-nvim'

" NVIM plugins
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'nathom/filetype.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'j-hui/fidget.nvim'
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
" => Indentline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char = '│'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => yadi
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Try to auto detect and use the indentation of a file when opened. 
autocmd BufRead * DetectIndent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AngryReviewerEnglish = 'american'
nnoremap <leader>ar :AngryReviewer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" On window resize, if goyo is active, do <c-w>= to resize the window
autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent> <leader>g :Goyo<cr>

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
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>s :Rg<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE

if has('nvim')
  colorscheme everforest
else
  colorscheme sonokai
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathfinder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>pe :PathfinderExplain<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Dirvish
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType dirvish
"   \ nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
"   \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
" 
" nmap <C-t> <Plug>(dirvish-toggle)
" nnoremap <silent> <Plug>(dirvish-toggle) :<C-u>call <SID>dirvish_toggle()<CR>
" 
" function! s:dirvish_toggle() abort
"   let l:last_buffer = bufnr('$')
"   let l:i = 1
"   let l:dirvish_already_open = 0
" 
"   while l:i <= l:last_buffer
"     if bufexists(l:i) && bufloaded(l:i) && getbufvar(l:i, '&filetype') ==? 'dirvish'
"       let l:dirvish_already_open = 1
"       execute ':'.l:i.'bd!'
"     endif
"     let l:i += 1
"   endwhile
" 
"   if !l:dirvish_already_open
"     35vsp +Dirvish
"   endif
" endfunction
" 
" function! s:dirvish_open() abort
"   let l:line = getline('.')
"   if l:line =~? '/$'
"     call dirvish#open('edit', 0)
"   else
"     call <SID>dirvish_toggle()
"     execute 'e '.l:line
"   endif
" endfunction
" 
" augroup dirvish_commands
"   autocmd!
"   "autocmd FileType dirvish call fugitive#detect(@%)
"   autocmd FileType dirvish nnoremap <silent> <buffer> <C-r> :<C-u>Dirvish %<CR>
"   autocmd FileType dirvish unmap <silent> <buffer> <CR>
"   autocmd FileType dirvish nnoremap <silent> <buffer> <CR> :<C-u> call <SID>dirvish_open()<CR>
"   autocmd FileType dirvish setlocal nonumber norelativenumber statusline=%F
"   autocmd FileType dirvish silent! keeppatterns g@\v/\.[^\/]+/?$@d
"   autocmd FileType dirvish execute ':sort r /[^\/]$/'
" augroup END

