if command -v /opt/homebrew/bin/brew > /dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "${XDG_CONFIG_HOME}/sec" ]; then
  for file in "${XDG_CONFIG_HOME}"/sec/startup/*.zsh ; do source $file; done
fi

[ -f /usr/local/bin/fastfetch ] && /usr/local/bin/fastfetch

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# install plugins
[ ! -d "${HOME}/.config/zsh/plugins/zsh-autocomplete" ] && git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git ${HOME}/.config/zsh/plugins/zsh-autocomplete
[ ! -d "${HOME}/.config/zsh/plugins/zsh-syntax-highlighting" ] && git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.config/zsh/plugins/zsh-syntax-highlighting
[ ! -d "${HOME}/.config/zsh/plugins/powerlevel10k" ] && git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.config/zsh/plugins/powerlevel10k

[[ -d $PYENV_ROOT/bin ]] && eval "$(pyenv init --path)"

if hash fzf 2>/dev/null; then
  eval "$(fzf --zsh)"
  zstyle ':autocomplete:tab:*' fzf-completion yes
fi

setopt interactivecomments

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


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# load aliases
source "$ZDOTDIR/.aliases.zsh"

# load plugins
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
source "$ZDOTDIR/.p10k.zsh"

zstyle ':autocomplete:*' delay 0.1
