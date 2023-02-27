export LANG=en_US.UTF-8
export COLORTERM="truecolor"
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"

export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"
export ZSH="$XDG_CONFIG_HOME/zsh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${(%):-%m}-${ZSH_VERSION}"
export HISTFILE="$ZSH/.zsh_history"

export GOPATH="$HOME/.go"
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PYENV_ROOT="$HOME/.pyenv"

export PATH="$HOME/.local/bin:/usr/local/bin/go/bin:$GOPATH/bin:$CARGO_HOME/bin:$NPM_HOME/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$XDG_CONFIG_HOME/bin:$PATH"
export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"
