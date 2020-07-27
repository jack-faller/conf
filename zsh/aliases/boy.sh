x="${1:?}"; shift; y=("${@:?}")

for i in "${y[@]}"; do
man "${x}" \
        | sed -n "s/.\\x08//g;/^\\s*${i}/,/^$/p" 
done
