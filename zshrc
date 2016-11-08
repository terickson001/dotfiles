#! /usr/bin/env zsh
# ~/.zshrc

source /usr/share/zsh/scripts/antigen/antigen.zsh

source /usr/share/base16/shell/base16-ocean.dark.sh

antigen bundle robbyrussell/oh-my-zsh lib/

antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme custom

#antigen bundle zsh-users/zsh-history-substring-search

