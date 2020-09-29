name="$HOME/bkp/$(pwd | tr '/' '%' | tr " " "_").bkp"
mkdir $name
cp * $name
