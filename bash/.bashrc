#
# ~/.bashrc
#

# Exports
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Wifi
alias lsnet="nmcli dev wifi"
alias connet="nmcli dev wifi connect"

# Misc
alias ll="exa"
alias icat="kitty icat"
alias clipboard="xclip -selection clipboard"
alias gohome="cd /media/data/mathew/Home"
alias whalefetch="neofetch --ascii \"$(fortune -s | cowthink -W 30 -f whale)\""
alias wiki="wiki-search"

eval $(thefuck --alias fuck)

# Fast configs
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc && source ~/.bashrc && clear"
alias i3config="vim ~/.config/i3/config"

# Set wallpapers with pywal
set-bg(){
    wal -n -i "$@" 
    walnotify4
    feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
}

set-light-bg(){
	wal -n -l -i "$@"
	walnotify4
    feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
}

push-dots(){
    cd ~/dotfiles
    git add .
    git commit -m "$@"
    git push
}

# Pywal Spotify
alias theme-spotify="oomoxify-cli -s /opt/spotify/Apps ~/.cache/wal/colors-oomox"

# Night light
alias night-light="redshift -l 37.548271:-121.988571"  

# Run startup

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
