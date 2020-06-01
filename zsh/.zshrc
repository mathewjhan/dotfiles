#
# ~/.zshrc
#

# School
alias college="cd /media/data/mathew/Home/College"
alias cs230="cd /media/data/mathew/Home/College/CS230"
alias cs250="cd /media/data/mathew/Home/College/CS250"
alias math233="cd /media/data/mathew/Home/College/MATH233"
alias eng112="cd /media/data/mathew/Home/College/ENGLWRIT112"

# Convenient aliases
alias e="nvim"
alias fm="vifm-ueberzug"
alias mp="ncmpcpp"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias gohome="cd /media/data/mathew/Home"

# Other stuff
alias weebtrash="cd /media/data/mathew/Home/trash"
alias left-monitor="xrandr --output eDP1 --auto  --right-of DP3 --output DP3 --auto"

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

# gpu switch modes (requires gpu-enable run already)
mode-bumblebee(){
    echo "Make sure you are not in optimus-manager nvidia"
    sudo modprobe -r nouveau
    sudo modprobe nvidia 
    sudo systemctl stop optimus-manager.service
    sudo systemctl disable optimus-manager.service
    sudo systemctl enable bumblebeed
    sudo systemctl start bumblebeed
    echo "Successfully changed to bumblebee"
}
mode-optimanager(){
    sudo systemctl stop bumblebeed
    sudo systemctl disable bumblebeed
    sudo systemctl enable optimus-manager.service
    sudo systemctl start optimus-manager.service
    echo "Successfully changed to optimus-manager"
}

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
alias rm="echo 'Please run rip (aka rm-improved) instead or rm with a backslash.'"
alias ls='exa'
alias icat="kitty icat"
alias clipboard="xclip -selection clipboard"
alias whalefetch="neofetch --ascii \"$(fortune -s | cowthink -W 30 -f whale)\" --disable uptime resolution de wm theme icons"
alias gitinfo="onefetch"
alias wiki="wiki-search"
alias wolfram="tungsten"
alias temps="paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'"

eval $(thefuck --alias fuck)

# Fast configs
alias vimrc="cd ~/.vim/vimrc.d && echo 'Changed directories to vimrc.d'"
alias bashrc="vim ~/.bashrc && source ~/.bashrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias i3config="vim ~/.config/i3/config"

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

# Theme spotify
alias theme-spotify="oomoxify-cli -s /opt/spotify/Apps ~/.cache/wal/colors-oomox"

# Update all themes not directly changed by wal
update-theme(){
    oomoxify-cli -s /opt/spotify/Apps ~/.cache/wal/colors-oomox
    zth & kill $(echo $!)
    xrdb -merge ~/.Xresources
}

# Manage dots
commit-dots(){
    cd ~/dotfiles
    git add .
    git commit -m "$@"  
}

# Clean pacman/yay cache
alias clean-pkg="sudo paccache -r -k 1 && yay -Sc"

## ZSH SPECIFIC
# vi mode
set -o vi
export KEYTIMEOUT=2
bindkey -v
bindkey "^?" backward-delete-char
bindkey '^h' backward-delete-char
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
