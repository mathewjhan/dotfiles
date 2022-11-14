#
# ~/.bashrc
#

# Defaults
alias e="nvim"
alias fm="vifm-ueberzug"
alias pdfr="zth"

te(){
    touch "$@"
    nvim "$@"
}

# Connman
#alias lsnet="connmanctl scan wifi && connmanctl services"
#alias connet="connmanctl connect"


# Network Manager

connet(){
    nmcli dev wifi connect "$(nmcli -f SSID dev wifi | grep -m 1 "$@" | sed 's/^ *//;s/ *$//')"
}
copynet(){
    nmcli -f SSID dev wifi | grep -m 1 "$@" | sed 's/^ *//;s/ *$//' | xclip -selection clipboard
}
alias lsnet="nmcli dev wifi"

# Misc
alias ls="exa"
alias rm="rm -I"
alias icat="kitty icat"
alias clipboard="xclip -selection clipboard"
alias gohome="cd /media/data/mathew/Home"
alias whalefetch="neofetch --ascii \"$(fortune -s | cowthink -W 30 -f whale)\""
alias wiki="wiki-search"
alias wolfram="tungsten"
alias temps="paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias pls="sudo !!"

# Fast configs
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc && source ~/.bashrc && clear"
alias i3config="vim ~/.config/i3/config"

# Lock
alias lock="xflock4"

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


# Night light
alias night-light="redshift -l 37.548271:-121.988571"  

# Run startup
# neofetch

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Bash prompt
#PS1='[\u@\h \W]\$ '
PS1="\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h \[\033[1;32m\]\w\[\033[0;37m\]\n\\$ \[$(tput sgr0)\]"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
