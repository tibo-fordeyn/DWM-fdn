#!/bin/bash
chosen=$(cut -d '#' -f 2 ~/.local/share/dmenu-scripting/snippets | dmenu -l 17)
[ -z "$chosen"  ] && exit
snippet=$(grep "$chosen" ~/.local/share/dmenu-scripting/snippets | cut -d '#' -f 1)

# Simuleert het typen van de snippet
setxkbmap be
xdotool type "$snippet"
xdotool key Return
#if [[ "$chosen" == *"http"*  ]]; then
	  #xdotool key Return
#fi


