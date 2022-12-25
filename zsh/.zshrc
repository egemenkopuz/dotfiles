# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# export ZSH=$HOME/.oh-my-zsh
# export XDG_CONFIG_HOME="$HOME/.config"

source "$HOME/antigen.zsh"
antigen init $HOME/.antigenrc

# ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins=(
#     sudo
#     git
#     last-working-dir
#     zsh-syntax-highlighting
#     zsh-autopair
#     zsh-autocomplete
# )
#
# source $ZSH/oh-my-zsh.sh

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

if grep -q "microsoft" /proc/version &>/dev/null; then
    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY="$(/sbin/ip route | awk "/default/ { print $3 }"):0"
    # Allows your gpg passphrase prompt to spawn (useful for signing commits).
    export GPG_TTY=$(tty)
fi

[[ ! -f $XDG_CONFIG_HOME/p10k/.p10k.zsh ]] || source $XDG_CONFIG_HOME/p10k/.p10k.zsh

__conda_setup="$("$HOME/miniconda3/bin/conda" "shell.zsh" "hook" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/nihilist/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
