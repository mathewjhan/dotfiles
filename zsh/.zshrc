#
# ~/.zshrc
#

# School
export uni="/media/data/mathew/Home/College"
alias math597u="cd /media/data/mathew/Home/College/MATH597U"
alias math545="cd /media/data/mathew/Home/College/MATH545"
alias cs590op="cd /media/data/mathew/Home/College/CS590OP"
alias music150="cd /media/data/mathew/Home/College/MUSIC150"
alias nbstart="cd /media/data/mathew/Home/College/MATH597U/Notebooks && source math597u/bin/activate && jupyter lab"
alias grad="cd /media/data/mathew/Home/grad"

# Convenient aliases
alias e="nvim"
alias fm='cd "$(xplr --print-pwd-as-result)"'
alias mp="ncmpcpp"
alias lg="lazygit"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias gohome="cd /media/data/mathew/Home"
alias logout="i3-msg exit"

# Other stuff
alias weebtrash="cd /media/data/mathew/Home/trash"
alias left-monitor="xrandr --output DP3 --auto --left-of eDP1 --primary  --auto && ~/.config/polybar/launch_polybar.sh </dev/null &>/dev/null &"
alias offload='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME="nvidia" __VK_LAYER_NV_optimus="NVIDIA_only" __GL_SHOW_GRAPHICS_OSD=1'
alias editsdf="nvim ~/.local/bin/sdf"
alias restartaudio="systemctl --user restart pipewire pipewire-pulse pipewire-media-session"

# Touch + edit
te(){
    touch "$@"
    nvim "$@"
}

# Vimtex
vt(){
    touch "$@"
    nvim "$@"
    latexmk -quiet -pdf -c "$@"
}


# Connman
#alias lsnet="connmanctl scan wifi && connmanctl services"
#alias connet="connmanctl connect"

# Network Manager
## Gets first network that matches and asks to connect
connet(){
    nmcli dev wifi connect "$(nmcli -f SSID dev wifi | grep -m 1 "$@" | sed 's/^ *//;s/ *$//')"
}
copynet(){
    nmcli -f SSID dev wifi | grep -m 1 "$@" | sed 's/^ *//;s/ *$//' | xclip -selection clipboard
}
alias lsnet="nmcli dev wifi"
alias restartnet="sudo modprobe -r ath10k_pci && sudo modprobe ath10k_pci"

# gpu switch modes (requires gpu-enable run already)
# I use optimus-manager only now
# mode-bumblebee(){
#     echo "Make sure you are not in optimus-manager nvidia"
#     sudo modprobe -r nouveau
#     sudo modprobe nvidia 
#     sudo systemctl stop optimus-manager.service
#     sudo systemctl disable optimus-manager.service
#     sudo systemctl enable bumblebeed
#     sudo systemctl start bumblebeed
#     echo "Successfully changed to bumblebee"
# }
# mode-optimanager(){
#     sudo systemctl stop bumblebeed
#     sudo systemctl disable bumblebeed
#     sudo systemctl enable optimus-manager.service
#     sudo systemctl start optimus-manager.service
#     echo "Successfully changed to optimus-manager"
# }

# nvidia-smi top
alias nvidiatop="watch -n 0.5 nvidia-smi"

# Pacman
# remove orphans
alias remorph="pacman -Qdt && sudo pacman -Rns \$(pacman -Qtdq)"

# update related
alias pacnews="sudo informant read"

# audit
alias pacaudit="arch-audit"

# Package specific
alias rm="echo 'Please run trash instead or rm with a backslash.'"
alias tp="trash-put"
alias ls='exa'
alias icat="kitty icat"
alias clipboard="xclip -selection clipboard"
alias fetch="neofetch --ascii \"$(echo carpe noctem, quam minimum credula postero | cowthink -W 30 -f whale)\" --disable term term_font uptime resolution memory de wm theme icons"
alias gitinfo="onefetch"
alias wiki="wiki-search"
alias wolfram="tungsten"
alias temps="paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'"

# Fast configs
alias vimrc="cd ~/.vim/vimrc.d && echo 'Changed directories to vimrc.d'"
alias bashrc="vim ~/.bashrc && source ~/.bashrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias i3config="vim ~/.config/i3/config"
alias nvimconfig="vim ~/.config/nvim/init.vim"

# Lock
alias lock="xflock4"

# Dell configuration
alias dellconf="sudo cctk"

# MPD
alias remove-playlist-dupes="mpc playlist | sort | uniq -d -c | while read song; do count=$(echo "$song" | sed -e "s/^[ \t]*//" | cut -d" " -f1); song=$(echo "$song" | sed -e "s/^[ \t]*//" | cut -d" " -f2-); for (( i = 2 ; i <= $count; i++ )); do mpc playlist | grep -n "$song" | tail -n 1 | cut -d: -f1 | mpc del; done; done"

# Extract all archives in directory and make subdirectory
# with same name as archive
extract-all(){
    for archive in "*.$@"; do
        7z x -o"`basename \"$archive\" .$@`" "$archive"
    done
}

# git
alias gittree="git log --graph --decorate --pretty=oneline --abbrev-commit"

# Theme spotify
alias theme-spotify="oomoxify-cli -s /opt/spotify/Apps ~/.cache/wal/colors-oomox"

# Update all themes not directly changed by wal
update-theme(){
    spicetify update
    reload_dunst.sh
    xrdb -merge ~/.Xresources
}

# Manage dots
commit-dots(){
    cd ~/dotfiles
    git add .
    git commit -m "$@"  
}

# Clean pacman/yay cache
alias cleanup="sudo paccache -r -k 2 && paru -Sc"
alias rebuildpy="paru -S $(LANG=C pacman -Qo /usr/lib/python3.10/ | cut -f5 -d\  | tr '\n' ' ')"

## ZSH SPECIFIC
# vi mode
set -o vi
export KEYTIMEOUT=2
bindkey -v
bindkey '^w' backward-kill-word

# better tab completion
autoload -U compinit
compinit

# tab completion from both ends
setopt completeinword

# case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# prompt
autoload -U promptinit; promptinit
prompt pure

# zsh syntax highlighitng
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
