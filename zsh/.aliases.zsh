_exists() {
  command -v $1 > /dev/null 2>&1
}

if _exists rsync; then
  alias cpv="rsync -ah --info=progress2 --no-inc-recursive --stats"    # progress bar
  alias rcopy="rsync -av --progress -h"
  alias rmove="rsync -av --progress -h --remove-source-files"
  alias rupdate="rsync -avu --progress -h"
  alias rsynchronize="rsync -avu --delete --progress -h"
fi

if _exists eza; then
  alias l="eza"
  alias la="eza -a --icons"
  alias ll="eza -lah --icons --git"
  alias llg="eza --grid -lah --icons --git"
  alias ls="eza --color=auto --icons"
else
  alias l="ls"
  alias ll="ls -lah"
  alias la="ls -a"
  alias ls="ls --color=auto"
fi

if _exists bat; then
  alias cat="bat -P"
fi

if _exists procs; then
  alias ps="procs"
fi

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

alias vi="nvim"
alias vim="nvim"

alias lg="lazygit"
alias g="lazygit"
alias t="tmux"
alias python="python3"
alias grep="grep -n --color"
alias mkdir="mkdir -pv"
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
