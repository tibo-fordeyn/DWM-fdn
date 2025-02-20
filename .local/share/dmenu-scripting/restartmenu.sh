#!/bin/bash
chosen=$(cut -d '#' -f 2 ~/.local/share/dmenu-scripting/restart | dmenu -l 10)
[ -z "$chosen"  ] && exit
snippet=$(grep "$chosen" ~/.local/share/dmenu-scripting/restart | cut -d '#' -f 1)

# Voert het commando uit
st -e sh -c "$snippet" &
