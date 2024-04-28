.PHONY: all

all: symlinks git-symlink

symlinks:
	echo "Creating symlinks..."
	ln -sf ${HOME}/.config/zsh/.zshenv ${HOME}/.zshenv
	ln -sf ${HOME}/.config/zsh/.zshrc ${HOME}/.zshrc

git-symlink:
	echo "Creating git symlink..."
	ln -sf ${HOME}/.config/git/.gitconfig ${HOME}/.gitconfig

