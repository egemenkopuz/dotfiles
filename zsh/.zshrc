if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

command -v pyenv >/dev/null
eval "$(pyenv init -)"

source "$XDG_CONFIG_HOME/antigen/antigen.zsh"
antigen init $XDG_CONFIG_HOME/antigen/.antigenrc

zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' fzf-completion yes

HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY          # write the history file in the ':start:elapsed;command' format
setopt SHARE_HISTORY             # share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS          # do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS         # do not display a previously found event
setopt HIST_IGNORE_SPACE         # do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS         # do not write a duplicate event to the history file
setopt HIST_VERIFY               # do not execute immediately upon history expansion

alias h="history"
alias hf="history | grep"

alias rm="rm -v"
alias cp="cp -iv"
alias mv="mv -iv"

alias vi="nvim"
alias vim="nvim"

alias l="exa"
alias la="exa -a --icons"
alias ll="exa -lah --icons --git"
alias ls="exa --color=auto --icons"

alias gg="lazygit"
alias python="python3"
alias grep="grep -n --color"
alias mkdir="mkdir -pv"
alias ps="ps -ef"
alias fd="fdfind"
alias cat="bat"
alias df="duf"
alias ps="procs"

tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

source "$ZDOTDIR/.p10k.zsh"

eval "$(zoxide init zsh)"

if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/miniconda3/bin:$PATH"
fi

while [ ! -z $CONDA_PREFIX ]; do conda deactivate; done
