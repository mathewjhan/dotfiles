#
# ~/.zshrc
#

# Defaults
export EDITOR=vim
export HOMEBREW_NO_AUTO_UPDATE=1
export DOTS=~/.dotfiles

# Convenient aliases
alias e="nvim"
alias lg="lazygit"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="eza"
alias ll="eza -la"

function fm {
    ranger $*
    local quit_cd_wd_file="$HOME/.ranger_quit_cd_wd"
    if [ -s "$quit_cd_wd_file" ]; then
        cd "$(cat $quit_cd_wd_file)"
        true > "$quit_cd_wd_file"
    fi
}

# Fast configs
alias vimrc="cd ~/.vim/vimrc.d && echo 'Changed directories to vimrc.d'"
alias bashrc="vim ~/.bashrc && source ~/.bashrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias nvimcfg="nvim ~/.config/nvim/init.lua"

# Extract all archives in directory and make subdirectory
# with same name as archive
extract-all(){
    for archive in "*.$@"; do
        7z x -o"`basename \"$archive\" .$@`" "$archive"
    done
}

# virtualenv to jupyter
venv-jupyter() {
    python -m ipykernel install --user --name="$@"
}


# git
alias gittree="git log --graph --decorate --pretty=oneline --abbrev-commit"

# ssh
alias ssh='env TERM=xterm ssh'

## ZSH SPECIFIC
# vi mode
set -o vi
export KEYTIMEOUT=2
bindkey -v
bindkey '^w' backward-kill-word
bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward

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
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi
