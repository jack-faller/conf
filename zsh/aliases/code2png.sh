name="`echo _$1 | sed 's/\..*//g'`"
highlight --font iosevka -l --style edit-godot -I -O html $1 | sed 's/﻿//g' | wkhtmltoimage - $name.png
