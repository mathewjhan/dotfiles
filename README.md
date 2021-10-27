# Dotfiles
Most of the dotfiles I am using on my current Linux distro.

**OS**: Arch Linux\
**DE**: None\
**WM**: i3-gaps\
**Shell**: zsh

![rice](rice.png?raw=true "Title")

# Currently in use:
| Functionality           | Program                                                                |
| -------------           | -------                                                                |
| Automounter             | [`udiskie`](https://github.com/coldfix/udiskie)                        |
| Compositor              | [`picom`](https://github.com/yshui/picom)                              |
| Dotfile management      | `git` + [`stow`](https://www.gnu.org/software/stow/)                   |
| File manager            | [`vifm`](https://github.com/vifm/vifm)                                 |
| Launcher/Window swapper | [`rofi`](https://github.com/davatorium/rofi)                           |
| Monitor manager         | [`autorandr`](https://github.com/phillipberndt/autorandr)              |
| Music player            | `mpd` + [`ncmpcpp`](https://github.com/ncmpcpp/ncmpcpp)                |
| Notifications           | [`dunst`](https://github.com/dunst-project/dunst)                      |
| PDF reader              | [`zathura`](https://github.com/pwmt/zathura)                           |
| Power management        | [`tlp`](https://github.com/linrunner/TLP)                              |
| Screenshot tool         | [`flameshot`](https://github.com/flameshot-org/flameshot)              |
| Taskbar                 | [`polybar`](https://github.com/polybar/polybar)                        |
| Terminal                | [`kitty`](https://github.com/kovidgoyal/kitty)                         |
| Text editor             | [`neovim`](https://github.com/neovim/neovim)                           |
| Theming                 | [`pywal`](https://github.com/dylanaraps/pywal)                         |
| Touchpad                | [`libinput-gestures`](https://github.com/bulletmark/libinput-gestures) |
| `rm` replacement        | [`rip`](https://github.com/nivekuil/rip)                               |

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
- nmguish 
- i3wm
- fonts: inconsolata, font awesome 5, hack

## kitty
- pywal
- san francisco mono (font)

## vim
- abstract.vim
- asyncrun.vim
- fzf.vim
- goyo.vim
- indentline
- markdown-preview.nvim
- neoformat
- pear-tree
- tabline.vim
- tabular
- tagbar
- ultisnips
- vim-airline
- vim-bookmarks
- vim-pandoc
- vim-pandoc-markdown-syntax
- vim-sandwich
- vim-sleuth
- vim-startuptime
- vim-surround
- vim-visual-multi
- vimtex

## neovim
- cmp-buffer
- cmp-nvim-lsp
- cmp-nvim-ultisnips
- cmp-path
- nvi-lsp-installer
- nvim-cmp
- nvim-lspconfig
- nvim-treesitter
