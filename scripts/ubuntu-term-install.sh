
#!/bin/bash

apps=(
	#  essentials
	'git'
	'tmux'
	'wget'
	'curl'

	# security
	'openssl'
	'gnupg'

	# terminal
	'zsh'
	# 'eza'
	# 'lazygit'
	# 'git-delta'
	'bat'
	# 'fastfetch'
	'fzf'
	'fd-find'
	'ripgrep'
	'diffutils'
	# 'procs'
	'duf'
	'btop'
	# 'just'

	# development
	'neovim'
	'npm'
	'python'
	'python-pip'
	'python-pynvim'
	# 'docker'
	# 'docker-compose'
)

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

add-apt-repository ppa:neovim-ppa/unstable
apt update
