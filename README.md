# Dotfiles
Most of the dotfiles I am using on my current Linux distro.

**OS**: Arch Linux\
**DE**: xfce4\
**WM**: i3\
**Shell**: zsh

![neofetch & cava](rice.png?raw=true "Title")

# Currently in use:
- Theming: `pywal`
- Taskbar: `polybar`
- Text editor: `nvim` 
- Compositor: `picom`
- Launcher/Window swapper: `rofi`
- Terminal: `kitty`
- Touchpad: `libinput-gestures`
- Power management: `tlp`
- Dotfile management: `stow` + `git`
- Screenshot tool: `flameshot`
- File manager: `vifm`
- Music player: `mpd` + `ncmpcpp`
- `rm` replacement: `rip`
- PDF reader: `zathura`

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
- flameshot (screenshot bindings)
- kitty (main term)
- pulseaudio (audio controls)
- rofi (launcher/workspace swapper)

## polybar 
- pulseaudio (module)
- pavucontrol (open pulseaudio controls)
- network manager
- nm-connection-editor 
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
- vim-airline
- vim-auto-save
- vim-bookmarks
- vim-pandoc
- vim-pandoc-markdown-syntax
- vim-pandoc-markdown-preview
- vim-surround
- vimtex
- vpmp-togglable (modified vim-pandoc-markdown-preview)
- wal.vim (theme that works with pywal)
