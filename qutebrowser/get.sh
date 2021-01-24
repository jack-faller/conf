#! /bin/sh

. "$HOME/.cache/wal/colors.sh"
url=$(cat ~/.config/qutebrowser/stowed | sort | dmenu -b -l 20 -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15")

if [ $(grep -x -v "$url" "$QUTE_CONFIG_DIR/stowed") = "" ]; then #don't open tabs not in file
    exit
fi

if [ "$url" != "" ]; then
    echo "open -t $url" >> "$QUTE_FIFO"
    grep -F -x -v "$url" "$QUTE_CONFIG_DIR/stowed" > "$QUTE_CONFIG_DIR/tmp_stowed" #remove url
    mv "$QUTE_CONFIG_DIR/tmp_stowed" "$QUTE_CONFIG_DIR/stowed"
fi
