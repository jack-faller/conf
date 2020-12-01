source ~/.config/zsh/common
#load x setings
xrdb ~/.config/Xresources

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    startx
fi

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


setxkbmap gb -option "caps:escape"
