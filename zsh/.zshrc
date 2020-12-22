source ~/.config/zsh/common
#load x setings
xrdb ~/.config/Xresources

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    startx
fi

setxkbmap gb -option "caps:escape"
