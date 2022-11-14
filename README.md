# Dotfiles
Most of the dotfiles I am using on my current Linux distro.

**OS**: Arch Linux\
**DE**: None\
**WM**: i3-gaps\
**Shell**: zsh

![rice](rice.png?raw=true "Title")

# Currently in use:

<center> 

| Functionality           | Program                                                                                             |
| -------------           | -------                                                                                             |
| Automounter             | [`udiskie`](https://github.com/coldfix/udiskie)                                                     |
| Compositor              | [`picom`](https://github.com/yshui/picom)                                                           |
| Dotfile management      | `git` + [`stow`](https://www.gnu.org/software/stow/)                                                |
| File manager            | [`xplr`](https://github.com/sayanarijit/xplr)                                                       |
| Launcher/Window swapper | [`rofi`](https://github.com/davatorium/rofi)                                                        |
| Monitor manager         | [`autorandr`](https://github.com/phillipberndt/autorandr)                                           |
| Music player            | [`mpd`](https://github.com/MusicPlayerDaemon/MPD) + [`ncmpcpp`](https://github.com/ncmpcpp/ncmpcpp) |
| Notifications           | [`dunst`](https://github.com/dunst-project/dunst)                                                   |
| PDF reader              | [`zathura`](https://github.com/pwmt/zathura)                                                        |
| Power management        | [`tlp`](https://github.com/linrunner/TLP)                                                           |
| Screenshot tool         | [`flameshot`](https://github.com/flameshot-org/flameshot)                                           |
| Taskbar                 | [`polybar`](https://github.com/polybar/polybar)                                                     |
| Terminal                | [`kitty`](https://github.com/kovidgoyal/kitty)                                                      |
| Text editor             | [`neovim`](https://github.com/neovim/neovim)                                                        |
| Theming                 | [`pywal`](https://github.com/dylanaraps/pywal)                                                      |
| Touchpad                | [`libinput-gestures`](https://github.com/bulletmark/libinput-gestures)                              |
| `rm` replacement        | [`trash-cli`](https://github.com/andreafrancia/trash-cli)                                           |

</center>

# Requirements

## i3
- Autorun/Startup
    - autorandr 
    - autotiling
    - dunst
    - feh
    - libinput (may require libinput gestures as well)
    - nm-applet
    - picom
    - polybar (with scripts)
    - pywal
    - redshift
    - udiskie
- flameshot (screenshot bindings)
- kitty (main term)
- pipewire (audio controls)
- rofi (launcher/workspace swapper)

## polybar 
- pulseaudio (module)
- pavucontrol (open pulseaudio/pipewire controls)
- network manager
- i3wm
- fonts: san francisco mono, font awesome 5, hack

## kitty
- pywal
- san francisco mono (font)

## vim
```
" Plugins
Plug 'anufrievroman/vim-angry-reviewer'
Plug 'cohama/lexima.vim'
Plug 'dstein64/vim-startuptime'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'julian/vim-textobj-variable-segment'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kana/vim-textobj-user'
Plug 'lervag/vimtex'
Plug 'machakann/vim-sandwich'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mkitt/tabline.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'preservim/tagbar'
Plug 'sbdchd/neoformat'
Plug 'SirVer/ultisnips'
Plug 'skywind3000/asyncrun.vim'
Plug 'timakro/vim-yadi'
Plug 'vim-airline/vim-airline'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'Yggdroot/indentLine'

" Themes
" Normal
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'

" Wal
Plug 'nekonako/xresources-nvim'
```

## neovim
```
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
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'nathom/filetype.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'j-hui/fidget.nvim'
endif
```
