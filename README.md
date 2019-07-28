# Dotfiles
Most of the dotfiles I am using on my current Linux distro =)

**OS**: Arch Linux\
**Host**: XPS 15 9750\
**DE**: Xfce4\
**WM**: i3-gaps\
**Shell**: zsh\

# Currently in use:
- Theming: pywal
- Taskbar: polybar
- Text editor: neovim (with vim8 plugins)
- Compositor: compton
- Launcher/Window swapper: rofi
- Terminal: kitty
- Touchpad: libinput-gestures
- Power management: tlp
- Dotfile management: stow + git
- Screenshot tool: fireshot
- File manager: vifm
- Music player: mpd + ncmpcpp
- PDF reader: zathura

# Requirements
- i3-gaps
    - Autorun/Startup
        - pywal
        - feh
        - compton
        - alternating_layouts.py
        - flashfocus
        - nm-applet
        - polybar (with scripts)
        - libinput (may require libinput gestures as well)
        - blurwal
        - redshift
    - fireshot (screenshot bindings)
    - kitty (main term)
    - pulseaudio (audio controls)
    - rofi (launcher/workspace swapper)

- polybar 
    - pulseaudio (module)
    - pavucontrol (open pulseaudio controls)
    - network manager
    - nm-connection-editor 
    - i3wm
    - fonts: inconsolata, font awesome 5, hack

- kitty
    - pywal
    - san francisco mono (font)

- vifm
    - ueberzug (previews in vifm, see config for specific details)
    - ffmpegthumbnailer

- neovim
    - asyncrun.vim
    - auto-pairs
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
