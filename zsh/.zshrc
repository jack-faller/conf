HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' #moar fuzz

export editor nvim

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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

#load colours
(cat ~/.cache/wal/sequences &)

#load x setings
xrdb ~/.config/Xresources

export PS1="%K{red}%F{black}%n@%m%f%k %F{blue}%~%f %#"

for alias in `ls $HOME/.config/zsh/aliases/`; do
	alias $alias="`cat "$HOME/.config/zsh/aliases/$alias" | awk '{print $0}'`"
done
alias vim="nvim"
alias vi="nvim"
alias la="lsd -a"
alias ls="lsd"
alias off="sudo shutdown now"
alias vifm="~/.config/vifm/scripts/vifmrun"
alias glances="glances -1"
alias fm="vifm ."
alias CAPS="xdotool key Caps_Lock"
alias caps="xdotool key Caps_Lock"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

setxkbmap -option "caps:escape"
setxkbmap gb

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Created by `userpath` on 2020-05-20 11:08:33
export PATH="$PATH:/home/jack/.local/bin"
