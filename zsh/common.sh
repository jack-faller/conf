HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' #moar fuzz

bindkey '^[[Z' reverse-menu-complete
bindkey '^[[Z' reverse-menu-complete

export PATH="$HOME/.config/zsh/aliases:$PATH"
export EDITOR=$(which em)
export VISUAL="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

export PS1="%K{red}%F{black}%n@%m%f%k %F{blue}%~%f %#"

alias vim="nvim"
alias vi="nvim"
alias ls="lsd -v"
alias la="lsd -Av"
alias ll="lsd -lAv"
alias se="sudoedit"
alias off="sudo shutdown now"
alias vifm="~/.config/vifm/scripts/vifmrun"
alias glances="glances -1"
alias fm="vifm ."
alias please="sudo"
alias tm="mv --verbose --backup --target-directory ~/trash"
alias pass="EDITOR='nvim -u NONE' pass"

cd-then () {
  cd $2 && eval $1
}

alias cd="cd-then 'lsd -v'"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct

# Created by `userpath` on 2020-05-20 11:08:33
export PATH="$PATH:/home/jack/.local/bin"

# fix delete
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^U" backward-kill-line            

#start ssh agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    ssh-add -q
else
    if [[ ! "$SSH_AUTH_SOCK" ]]; then
        source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    fi
fi

cat ~/.cache/wal/sequences

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#start tmux
if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]; then
    # if not inside a tmux session, and if no session is started, start a new session
    # create new window when clients already running
    if [[ $(pgrep tmux:\ client) != "" ]]; then
        [ -z "${TMUX}" ] && (tmux attach \; new-window >/dev/null 2>&1 || tmux)
    else
        [ -z "${TMUX}" ] && (tmux attach >/dev/null 2>&1 || tmux)
    fi
fi
