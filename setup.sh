#!/bin/sh

DOT_FILES=( .zshrc .emacs.d .tigrc .gitconfig.global)

for file in ${DOT_FILES[@]}
do
	[ ! -e $HOME/$file ] && ln -s $HOME/dotfiles/$file $HOME/$file
done

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# emacs
if [ ! -d ~/.emacs.d/ ] ; then
	[ ! -d ~/.emacs.d/public_repos ] && mkdir ~/.emacs.d/public_repos
	[ ! -d ~/.emacs.d/elpa ] && mkdir ~/.emacs.d/elpa
fi
