#!/bin/bash

apps=(
	#  essentials
	'git'
	'tmux'
	'wget'
	'curl'
	'man'

	# security
	'openssl'
	'gnupg'

	# terminal
	'zsh'
	'eza'
	'lazygit'
	'git-delta'
	'bat'
	'fastfetch'
	'fzf'
	'fd'
	'fzf'
	'ripgrep'
	'diffutils'
	'procs'
	'duf'
	'btop'
	'just'

	# development
	'neovim'
	'npm'
	'python'
	'python-pip'
	'python-pynvim'
	'docker'
	'docker-compose'
)

install_package() {
	echo "Do you want to install $1? [y/n]"
	read -r answer
	if [ "$answer" != "${answer#[Yy]}" ]; then
		pacman -S "$1"
	fi
}

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

if ! command -v pacman &>/dev/null; then
	echo "pacman is not installed"
	exit 1
fi

echo "Do you want to install all packages at once? [y/n]"
read -r answer

if [ "$answer" != "${answer#[Yy]}" ]; then
	echo "Installing all packages at once"
	pacman -S "${apps[@]}"
else
	echo "Installing individual packages"
	for package in "${apps[@]}"; do
		install_package "$package"
	done
fi
