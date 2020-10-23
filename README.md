# Dotfiles
Most of the dotfiles I am using on my current Linux distro.

**OS**: Arch Linux\
**DE**: None\
**WM**: i3-gaps\
**Shell**: zsh

![neofetch & cava](rice.png?raw=true "Title")

# Currently in use:
- Theming: [`pywal`](https://github.com/dylanaraps/pywal)
- Taskbar: [`polybar`](https://github.com/polybar/polybar)
- Text editor: [`neovim`](https://github.com/neovim/neovim) 
- Compositor: [`picom`](https://github.com/yshui/picom)
- Launcher/Window swapper: [`rofi`](https://github.com/davatorium/rofi)
- Terminal: [`kitty`](https://github.com/kovidgoyal/kitty)
- Touchpad: [`libinput-gestures`](https://github.com/bulletmark/libinput-gestures)
- Power management: [`tlp`](https://github.com/linrunner/TLP)
- Dotfile management: `git` + [`stow`](https://www.gnu.org/software/stow/)
- Screenshot tool: [`flameshot`](https://github.com/flameshot-org/flameshot)
- File manager: [`vifm`](https://github.com/vifm/vifm)
- Music player: `mpd` + [`ncmpcpp`](https://github.com/ncmpcpp/ncmpcpp)
- `rm` replacement: [`rip`](https://github.com/nivekuil/rip)
- PDF reader: [`zathura`](https://github.com/pwmt/zathura)
- Automounter: [`udiskie`](https://github.com/coldfix/udiskie)
- Notifications: [`dunst`](https://github.com/dunst-project/dunst)
- Monitor manager: [`autorandr`](https://github.com/phillipberndt/autorandr)

# Requirements

## i3
- Autorun/Startup
    - pywal
    - feh
    - picom
    - autotiling
    - nm-applet
    - polybar (with scripts)
    - libinput (may require libinput gestures as well)
    - redshift
    - dunst
    - udiskie
    - autorandr 
- flameshot (screenshot bindings)
- kitty (main term)
- pulseaudio (audio controls)
- rofi (launcher/workspace swapper)

## polybar 
- pulseaudio (module)
- pavucontrol (open pulseaudio controls)
- network manager
- nmguish 
- i3wm
- fonts: inconsolata, font awesome 5, hack

## kitty
- pywal
- san francisco mono (font)

## vifm
- ueberzug (previews in vifm, see config for specific details)
- ffmpegthumbnailer

## neovim
- asyncrun.vim
- pear-tree
- coc.nvim
- goyo.vim
- nerdcommenter
- tabular
- tabline.vim
- vim-airline
- vim-bookmarks
- vim-pandoc
- vim-pandoc-markdown-syntax
- vim-smoothie
- vim-surround
- vimtex
- ultisnips
- wal.vim (theme that works with pywal)
