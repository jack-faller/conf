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
_comp_options+=(globdots)		# Include hidden files.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' #moar fuzz

bindkey '^[[Z' reverse-menu-complete
bindkey '^[[Z' reverse-menu-complete

export EDITOR="/bin/nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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

#load colours
(cat ~/.cache/wal/sequences &)

#load x setings
xrdb ~/.config/Xresources

export PS1="%K{red}%F{black}%n@%m%f%k %F{blue}%~%f %#"

for alias in `ls $HOME/.config/zsh/aliases/`; do
	alias `echo $alias | sed 's/\.sh//'`="$HOME/.config/zsh/aliases/$alias"
done
alias vim="nvim"
alias vi="nvim"
alias la="lsd -a"
alias ls="lsd"
alias off="sudo shutdown now"
alias vifm="~/.config/vifm/scripts/vifmrun"
alias glances="glances -1"
alias fm="vifm ."
alias please="sudo"
alias tm="mv -t /tmp"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

setxkbmap gb -option "caps:escape"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Created by `userpath` on 2020-05-20 11:08:33
export PATH="$PATH:/home/jack/.local/bin"

# needs to be twice for some reason
bindkey '^[[3~' vi-delete-char
bindkey '^L' vi-delete-char
bindkey '^H' vi-backward-delete-char

bindkey '^[^j' vi-down-line-or-history
bindkey '^[^k' vi-up-line-or-history
bindkey '^[^h' vi-backward-char
bindkey '^[^l' vi-forward-char
if [ -e /home/jack/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jack/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
