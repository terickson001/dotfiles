#! /usr/bin/env bash

while true; do
    read -p "This will backup and replace your current ~/.vimrc. Would you like to continue? [Y/n]" replace
    case $replace in
        [Yy]* ) echo "Moving ~/.vimrc to ~/.vim/.vimrc.bak"; mv ~/.vimrc ~/.vim/.vimrc.bak; echo "runtime vimrc" > ~/.vimrc; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer [Y]es or [N]o.";;
    esac
done

mkdir ~/.vim/bundle

while true; do
    read -p "Would you like to download the plugins automatically, or manually in vim?[Y/n]" install
    case $install in
        [Yy]* ) echo "Downloading Plugins.."; break;;
        [Nn]* ) echo "To manually install the plugins, open vim and enter \":PluginInstall\""; exit;;
        * ) echo "Please answer [Y]es or [N]o.";;
    esac
done

while IFS='' read -r line || [[ -n "$line" ]]; do 
    if [ "${line:0:6}" == "Plugin" ]; then
        if [[ ${line:8:-1} == "Plugin ['\"]\\W" ]]; then
            $line 
        if [[ ${line:8:-1} == *"/"* ]]; then
            REPO=${line:8:-1}
            PACKAGE=(${line//// })
            PACKAGE=${PACKAGE[1]} 
        else
            REPO=vim-scripts/${line:8:-1}
            PACKAGE=${line:8:-1}
        fi
        echo "  Installing $PACKAGE"
        if [ ! -d "$HOME/.vim/bundle/$PACKAGE" ]; then
            git clone https://github.com/$REPO.git $HOME/.vim/bundle/$PACKAGE 2>&1 | sed 's/^/    /'
        else
            echo "  $PACKAGE already installed, skipping.."
        fi
    fi
done < "/home/tyler/.vim/vimrc"
