#
# ~/.zshrc
#

# Defaults
export EDITOR=vim

# Convenient aliases
alias e="nvim"
alias lg="lazygit"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

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
alias i3config="vim ~/.config/i3/config"
alias nvimconfig="vim ~/.config/nvim/init.vim"

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

# z
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
