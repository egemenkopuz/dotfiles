if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOME/antigen.zsh"
antigen init $HOME/.antigenrc

zstyle ':autocomplete:*' min-input 1

export LANG=en_US.UTF-8

#zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias vi="nvim"
alias vim="nvim"
alias l="exa"
alias la="exa -a --icons"
alias ll="exa -lah --icons"
alias ls="exa --color=auto --icons"
alias grep="grep -n --color"
alias mkdir="mkdir -pv"
alias ps="ps -ef"
alias fd="fdfind"
alias cat="batcat"
alias df="duf"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

m() { python3 -c "from math import *; print($*)" }

source $HOME/.p10k.zsh

__conda_setup="$("$HOME/miniconda3/bin/conda" "shell.zsh" "hook" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
