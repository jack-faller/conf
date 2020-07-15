histfiles=`ls ~/.config/nvim/histfiles`
for histfile in $histfiles
do
        if ! test -f `echo $histfile | sed 's#%#/#g'`; then
                mv "$HOME/.config/nvim/histfiles/$histfile" /tmp
        fi
done
