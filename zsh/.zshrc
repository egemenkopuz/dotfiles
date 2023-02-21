if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

f="$HOME/.nvm/nvm.sh"
if [ -r "$f" ]; then
  . "$f" &>'/dev/null'
  nvm use --lts &>'/dev/null'
fi

source "$XDG_CONFIG_HOME/antigen/antigen.zsh"
antigen init $XDG_CONFIG_HOME/antigen/.antigenrc

zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' fzf-completion yes

HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

alias xclip="xclip -selection clipboard"

alias gg="lazygit"

alias h="history"
alias hf="history | grep"

alias rm="rm -v"
alias cp="cp -iv"
alias mv="mv -iv"

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
alias ps="procs"

source "$ZDOTDIR/.p10k.zsh"

eval "$(zoxide init zsh)"

if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/miniconda3/bin:$PATH"
fi

while [ ! -z $CONDA_PREFIX ]; do conda deactivate; done

export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
