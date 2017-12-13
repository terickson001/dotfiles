#! /usr/bin/env zsh
# ~/.zshrc

source /usr/share/zsh/share/antigen.zsh
source $HOME/.antigen/custom/colors

source $HOME/.colors/base16-muted2.sh

bindkey -e

function prompt_git_info() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    local remote_ahead=$(git status -uno 2>/dev/null | grep -q "Your branch is behind"; echo  $?)
    local local_ahead=$(git status -uno 2>/dev/null | grep -q "Your branch is ahead"; echo $?)
    local color=white
    if [[ -z $branch ]]; then
        return
    elif [[ -z $(git status --porcelain) ]]; then
        local color=green
    else
        local color=yellow
    fi
    # echo "|[git:$branch]"
    local ahead_marker=""
    if [ "$remote_ahead" -eq "0" ]; then
        local ahead_marker="^"
    elif [ "$local_ahead" -eq "0" ]; then
        local ahead_marker="*"
    fi
    echo "%{$fg_bold[blue]%}|%{$fg[red]%}[git:%{$fg_bold[$color]%}$branch%{$fg[magenta]%}$ahead_marker%{$fg[red]%}]%{$reset_color%}"
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
antigen bundle chrissicool/zsh-bash

export EDITOR=vim

alias ":q"=exit
alias "edit"=$EDITOR
alias ":e"="edit"
alias ":qa"="pkill -9 urxvtc"
alias "yi"="yi --frontend vty --keymap vim"
alias "ls"="ls --color=always -F"
alias "svim"="ssh-agent -- vim -c '!ssh-add'"

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.4.0/bin:$HOME/.bin:$HOME/opt/ARMCompiler6.8/bin"
export MONITOR=$(xrandr -q | grep primary | cut -d " " -f 1)
export LC_COLLATE="C"
export LC_ALL=en_US.UTF-8
export ECLIPSE_HOME="$HOME/.eclipse/org.eclipse.platform_4.7.0_155965261_linux_gtk_x86_64"

antigen apply
