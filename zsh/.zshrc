#
# ~/.bashrc
#

# Exports
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export EDITOR="nvim"
export WINHOME="/media/data/mathew/Home"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Defaults
alias e="nvim"
alias fm="vifm-ueberzug"

te(){
    touch "$@"
    nvim "$@"
}

# Connman
#alias lsnet="connmanctl scan wifi && connmanctl services"
#alias connet="connmanctl connect"


# Network Manager

copynet(){
    nmcli dev wifi connect $(nmcli -f SSID dev wifi | grep -m 1 "$@" | awk '{$1=$1};1')
}
alias lsnet="nmcli dev wifi"
alias connet="nmcli dev wifi connect"

# Misc
alias ll="exa"
alias icat="kitty icat"
alias clipboard="xclip -selection clipboard"
alias gohome="cd /media/data/mathew/Home"
alias whalefetch="neofetch --ascii \"$(fortune -s | cowthink -W 30 -f whale)\""
alias wiki="wiki-search"
alias wolfram="tungsten"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias pls="sudo !!"

eval $(thefuck --alias fuck)

# Fast configs
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc && source ~/.bashrc && clear"
alias zshrc="vim ~/.zshrc && source ~/.zshrc && clear"
alias i3config="vim ~/.config/i3/config"

# Lock
alias lock="xflock4"

# MPD
alias remove-playlist-dupes="mpc playlist | sort | uniq -d -c | while read song; do count=$(echo "$song" | sed -e "s/^[ \t]*//" | cut -d" " -f1); song=$(echo "$song" | sed -e "s/^[ \t]*//" | cut -d" " -f2-); for (( i = 2 ; i <= $count; i++ )); do mpc playlist | grep -n "$song" | tail -n 1 | cut -d: -f1 | mpc del; done; done"

# Set wallpapers with pywal
set-bg(){
    wal -n -i "$@" 
    walnotify4
    feh --bg-scale "$(< "${HOME}/.cache/wal/wal")" 
    sudo cp "$@" /usr/share/lightdm-webkit/themes/modern/bg
    sudo convert "$@" -blur 0x8 /usr/share/lightdm-webkit/themes/modern/bg-blurred
}

set-light-bg(){
	wal -n -l -i "$@"
	walnotify4
    feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
    oomoxify-cli -s /usr/share/spotify/Apps ~/.cache/wal/colors-oomox
    sudo cp "$@" /usr/share/lightdm-webkit/themes/modern/bg
    sudo convert "$@" -blur 0x8 /usr/share/lightdm-webkit/themes/modern/bg-blurred

}

# Theme spotify
alias theme-spotify="oomoxify-cli -s /usr/share/spotify/Apps ~/.cache/wal/colors-oomox"

# Manage dots
commit-dots(){
    cd ~/dotfiles
    git add .
    git commit -m "$@"  
}

## ZSH SPECIFIC 
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

# z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
