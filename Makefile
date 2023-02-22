.PHONY: all

all: install dependencies

dependencies: symlinks python-pkgs rust-pkgs neovim-sync install-lazydocker install-lazygit
docker-dependencies: symlinks neovim-sync

install:
	git clone https://github.com/egemenkopuz/.config.git ${HOME}/.config

symlinks:
	echo "Creating symlinks..."
	ln -sf ${HOME}/.config/zsh/.zshenv ${HOME}/.zshenv
	ln -sf ${HOME}/.config/zsh/.zshrc ${HOME}/.zshrc
	ln -sf ${HOME}/.config/git/.gitconfig ${HOME}/.gitconfig

python-pkgs:
	echo "Installing python packages..."
	pip3 install --no-cache-dir --user virtualenv black isort flake8 pydocstyle mypy pynvim

rust-pkgs:
	echo "Installing rust packages"
	curl https://sh.rustup.rs -sSf | bash -s -- -y
	cargo install git-delta

install-lazygit:
	echo "Installing lazygit..."
	go install github.com/jesseduffield/lazygit@latest

install-lazydocker:
	echo "Installing lazydocker..."
	go install github.com/jesseduffield/lazydocker@latest

neovim-sync:
	echo "Syncing neovim plugins..."
	nvim --headless "+Lazy! sync" +qa
