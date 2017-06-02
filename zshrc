#! /usr/bin/env zsh
# ~/.zshrc

source /usr/share/zsh/share/antigen.zsh
source $HOME/.antigen/custom/colors

source $HOME/.colors/base16-muted2.sh

bindkey -e

function prompt_git_info() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    local color=white
    if [[ -z $branch ]]; then
        return
    elif [[ -z $(git status --porcelain) ]]; then
        local color=green
    else
        local color=yellow
    fi
    # echo "|[git:$branch]"
    echo "%{$fg_bold[blue]%}|%{$fg[red]%}[git:%{$fg_bold[$color]%}$branch%{$fg[red]%}]%{$reset_color%}"
}

function prompt_color() {
    if [[ $? != 0 ]]; then
        local color=red
    elif [[ $USER = root ]]; then
        local color=yellow
    else
        local color=green
    fi
    echo $color
}

setopt PROMPT_SUBST 

# PROMPT='>' 
PROMPT='%{$fg_bold[$(prompt_color)]%}>%{$reset_color%} ' 
RPROMPT='%~$(prompt_git_info)'


antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

export EDITOR=vim

alias ":q"=exit
alias "edit"=$EDITOR
alias ":e"="edit"
alias ":qa"="pkill -9 urxvt"
alias "yi"="yi --frontend vty --keymap vim"

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export MONITOR=$(xrandr -q | grep primary | cut -d " " -f 1)

antigen apply
