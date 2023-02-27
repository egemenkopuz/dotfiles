.PHONY: all

all: symlinks python-pkgs rust-pkgs go-pkgs neovim-sync

install:
	git clone --filter=blob:none --depth 1 https://github.com/egemenkopuz/.config.git ${HOME}/.config

install-dev:
	git clone https://github.com/egemenkopuz/.config.git ${HOME}/.config

symlinks:
	echo "Creating symlinks..."
	ln -sf ${HOME}/.config/zsh/.zshenv ${HOME}/.zshenv
	ln -sf ${HOME}/.config/zsh/.zshrc ${HOME}/.zshrc
	ln -sf ${HOME}/.config/git/.gitconfig ${HOME}/.gitconfig

python-pkgs:
	echo "Installing python packages..."
	if which pip3 >/dev/null; then \
		pip3 install --no-cache-dir --user \
		virtualenv \
		black \
		isort \
		flake8 \
		pydocstyle \
		mypy \
		pynvim; \
	else \
		echo "pip not found. Skipping python packages installation."; \
	fi

rust-pkgs:
	echo "Installing rust packages..."
	if which cargo >/dev/null; then \
		cargo install --locked zoxide;  \
		cargo install --locked bat; \
		cargo install exa; \
		cargo install ripgrep; \
		cargo install fd-find; \
		cargo install procs; \
		cargo install git-delta; \
		cargo install tre-command; \
	else \
		echo "cargo not found. Skipping rust packages installation."; \
	fi

go-pkgs:
	echo "Installing go packages..."
	if which go >/dev/null; then \
		go install github.com/jesseduffield/lazydocker@latest; \
		go install github.com/jesseduffield/lazygit@latest; \
	else \
		echo "go not found. Skipping go packages installation."; \
	fi

neovim-sync:
	echo "Syncing neovim plugins..."
	if which nvim >/dev/null; then \
		nvim --headless "+Lazy! sync" +qa; \
	else \
		echo "nvim not found. Skipping neovim plugin sync."; \
	fi
