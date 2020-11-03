ls -A > /tmp/efiles_list

#read lines to array
IFS=$'\n' read -d '' -r -a old_names < /tmp/efiles_list

ls -A | cat -n - > /tmp/efiles_list

$EDITOR /tmp/efiles_list

IFS=$'\n' read -d '' -r -a new_names < /tmp/efiles_list
for i in "${new_names[@]}"
do
    num=`echo $i | grep -o '^\W*[0-9]*' | grep -o '[0-9]*'`
    new_name=`echo "$i" | sed 's/^\W*[0-9]*\W//'`

    #cat -n is 1 based so sub 1 from num
    #suppress error on try to move file to self
    mv "${old_names[$num-1]}" "$new_name" 2> /dev/null \
        && echo 'changed "'"${old_names[$num-1]}"'" to "'"$new_name"'"'
done
