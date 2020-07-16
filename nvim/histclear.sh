histfiles=`ls ~/.config/nvim/histfiles`
echo "related file/s do not exist, moving to /tmp:"
for histfile in $histfiles
do
        if ! test -f `echo $histfile | sed 's#%#/#g'`; then
                mv "$HOME/.config/nvim/histfiles/$histfile" /tmp
                echo "    $histfile"
        fi
done
