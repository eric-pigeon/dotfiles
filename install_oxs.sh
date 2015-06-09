#!/bin/bash

echo -n "Replace existing dot files (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
	# remove old files {{{
	sudo rm -r ~/.vim > /dev/null 2>&1
	sudo rm ~/.vimrc > /dev/null 2>&1
	sudo rm ~/.tmux.conf > /dev/null 2>&1
	# }}}

	# create smylinks in home folder {{{
	ln -s ~/dotfiles/vim ~/.vim
	ln -s ~/dotfiles/vimrc ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/ctags ~/.ctags

	# create vim temp folders
	mkdir -p ~/.vim/tmp/swap
	mkdir -p ~/.vim/tmp/undo
	mkdir -p ~/.vim/tmp/backup
	# }}}

	echo -n "Choose your shell (bash/zsh) => "; read answer
	case $answer in
		# bash {{{
		"bash")
			sudo rm ~/.bashrc > /dev/null 2>&1
			sudo rm ~/.bash_profile > /dev/null 2>&1
			ln -s ~/dotfiles/bashrc ~/.bashrc
			ln -s ~/dotfiles/bash_profile ~/.bash_profile
			chsh -s /bin/bash
		;;
		# }}}
		# zsh {{{
		"zsh")
			if [[ ! -d ~/.antigen ]] ; then
				git clone https://github.com/zsh-users/antigen.git ~/dotfiles/zsh/antigen/
			fi

			sudo rm ~/.zshrc > /dev/null 2>&1

			ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
			chsh -s /bin/zsh
		;;
		# }}}
	esac
fi

# OSX defaults {{{
echo -n "Set up OSX defaults (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
	source ./osx-defaults.sh
fi
# }}}
