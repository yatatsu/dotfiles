#!/bin/sh

DOT_FILES=(.emacs.d .tigrc .gitconfig.global .config)

for file in ${DOT_FILES[@]}
do
	[ ! -e $HOME/$file ] && ln -s $HOME/dotfiles/$file $HOME/$file
done

# emacs
if [ -d ~/dotfiles/.emacs.d/ ] ; then
	[ ! -d ~/dotfiles/.emacs.d/public_repos ] && mkdir ~/dotfiles/.emacs.d/public_repos
	[ ! -d ~/dotfiles/.emacs.d/elpa ] && mkdir ~/dotfiles/.emacs.d/elpa
fi
