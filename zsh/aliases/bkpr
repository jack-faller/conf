mkdir -p "$HOME/bkp"
name="$HOME/bkp/$(pwd | tr '/' '%' | tr " " "_").bkp"
for (( i=0;; i++ )) 
do
    mkdir "$name($i)" && break
done
cp -r * "$name($i)"
