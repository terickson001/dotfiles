#! /usr/bin/env zsh
# ~/.zshrc

source /usr/share/zsh/scripts/antigen/antigen.zsh

source /usr/share/base16/shell/base16-ocean.dark.sh

source $HOME/.antigen/custom/colors
#antigen bundle robbyrussell/oh-my-zsh lib/

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
    echo "%{$fg_bold[blue]%}|[git:%{$fg_bold[$color]%}$branch%{$reset_color%}]"
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

PROMPT='%{$fg_bold[$(prompt_color)]%}>%{$reset_color%} ' 
RPROMPT='%~$(prompt_git_info)'

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search



