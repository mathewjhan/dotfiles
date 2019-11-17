#
# ~/.bashrc
#

# Exports
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export EDITOR="nvim"
export WINHOME="/media/data/mathew/Home"
export MUSIC="/media/data/mathew/Music"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH="$HOME/go"
export ANDROID_HOME="/opt/android-sdk"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export COLLEGE="/media/data/mathew/Home/College"
export CS187="/media/data/mathew/Home/College/CS187"

# Convenient aliases
alias e="nvim"
alias fm="vifm-ueberzug"
alias mp="ncmpcpp"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

## Touch + edit
te(){
    touch "$@"
    nvim "$@"
}

# School
alias checkstyle="java -jar checkstyle-8.18-all.jar -c 187style.xml"

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

alias nvtop="watch -n 0.5 nvidia-smi"

# Misc
alias ls='exa'
alias rm="rm -I"
alias icat="kitty icat"
alias clipboard="xclip -selection clipboard"
alias gohome="cd /media/data/mathew/Home"
alias whalefetch="neofetch --ascii \"$(fortune -s | cowthink -W 30 -f whale)\" --disable uptime resolution de wm theme icons"
alias wiki="wiki-search"
alias wolfram="tungsten"
alias temps="paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'"

eval $(thefuck --alias fuck)

# Fast configs
alias vimrc="cd ~/.vim/vimrc.d && echo 'Changed directories to vimrc.d'"
alias bashrc="vim ~/.bashrc && source ~/.bashrc && clear"
alias zshrc="vim ~/.zshrc && source ~/.zshrc && clear"
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
