#!/bin/sh

DOT_FILES=( .zshrc .emacs.d .tigrc .gitconfig.global)

for file in ${DOT_FILES[@]}
do
	[ ! -e $HOME/$file ] && ln -s $HOME/dotfiles/$file $HOME/$file
done

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# emacs
if [ -d ~/dotfiles/.emacs.d/ ] ; then
	[ ! -d ~/dotfiles/.emacs.d/public_repos ] && mkdir ~/dotfiles/.emacs.d/public_repos
	[ ! -d ~/dotfiles/.emacs.d/elpa ] && mkdir ~/dotfiles/.emacs.d/elpa
fi
