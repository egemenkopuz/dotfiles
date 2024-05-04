if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# install plugins
[ ! -d "${HOME}/.config/zsh/plugins/zsh-autocomplete" ] && git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git ${HOME}/.config/zsh/plugins/zsh-autocomplete
[ ! -d "${HOME}/.config/zsh/plugins/powerlevel10k" ] && git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.config/zsh/plugins/powerlevel10k

# zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# zstyle ':autocomplete:*' min-input 1
# zstyle ':autocomplete:*' fzf-completion yes

HISTSIZE=100000
HISTFILESIZE=$HISTSIZE
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

alias h="history 1"
alias hf="history 1 | grep"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias cls="clear"
alias count="find . -type f | wc -l"
alias chmod="chmod -c --preserve-root"
alias chown="chown -c --preserve-root"
alias chgrp="chgrp -c --preserve-root"
alias chmox="chmod +x --preserve-root"
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"

if hash rsync 2>/dev/null; then
  alias cpv="rsync -ah --info=progress2 --no-inc-recursive --stats"    # progress bar
  alias rcopy="rsync -av --progress -h"
  alias rmove="rsync -av --progress -h --remove-source-files"
  alias rupdate="rsync -avu --progress -h"
  alias rsynchronize="rsync -avu --delete --progress -h"
fi

alias vi="nvim"
alias vim="nvim"

alias l="eza"
alias la="eza -a --icons"
alias ll="eza -lah --icons --git"
alias llg="eza --grid -lah --icons --git"
alias ls="eza --color=auto --icons"

alias lg="lazygit"
alias t="tmux"
alias g="lazygit"
alias python="python3"
alias grep="grep -n --color"
alias mkdir="mkdir -pv"
alias cat="bat -P"
alias ps="procs"
alias nf="fastfetch"
alias df="df -h"
alias du="du -hs"

alias new="/usr/bin/ls -lth | head -15"
alias big="command du -a -BM | sort -n -r | head -n 10"

alias d="docker"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dim="docker images"
alias drun="docker run -it"
alias dl="docker logs -f"
alias ds="docker stop"
alias dr="docker rm"
alias dsp="docker system prune --all"
function dsr() { docker stop $1;docker rm $1 }

alias ve="python3 -m venv ./venv"
function va() {
  if [ -d "./.venv" ]; then
    source ./.venv/bin/activate
  elif [ -d "./venv" ]; then
    source ./venv/bin/activate
  else
    echo "No virtual environment found"
  fi
}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# load plugins
source "$ZDOTDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
source "$ZDOTDIR/.p10k.zsh"
