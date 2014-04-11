#!/bin/sh

DOT_FILES=( .zshrc .emacs.d .tigrc)

for file in ${DOT_FILES[@]}
do
	[ ! -e $HOME/$file ] && ln -s $HOME/dotfiles/$file $HOME/$file
done

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
