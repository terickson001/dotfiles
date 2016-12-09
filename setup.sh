#! /usr/bin/env bash

shopt -s extglob
dir=$HOME/dotfiles
olddir=$HOME/dotfiles_old

cd $dir
files=!(@(`basename "$0"`|.git|.gitignore|install.sh|dependencies))

echo "Creating '$olddir' to backup current dotfiles"
mkdir -p $olddir
echo "...done"


for file in $files; do
	if [ -f "$HOME/.$file" ]; then
		echo "Moving '$HOME/.$file' to '$olddir'"
		mv $HOME/.$file $olddir/$file
	fi
	echo "Creating Symlink to '$file' in '$HOME'"
	ln -s $dir/$file $HOME/.$file
done
