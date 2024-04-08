# ~/.bashrc

# Neofetch uitschakelen
neofetch

# Algemene modes
set -o vi

# Importeer kleurenschema van wal
# Hiermee wordt er van uitgegaan dat wal correct is geïnstalleerd en geconfigureerd
# en dat er een kleurenschema beschikbaar is in ~/.cache/wal
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    . "$HOME/.cache/wal/colors.sh"
fi

# Aanpassen van de prompt
# De prompt toont de huidige map in een gekleurde rechthoek
# Kleuren kunnen worden aangepast door de waarden van de wal-kleurenschema te gebruiken
PS1='\[$background_color\] \w \[$reset_color\]\$ \[$foreground_color\]'

# Shortcuts en belangrijke commando's
bind '"\C-l":"clear\n"'
bind '"\C-r":"ranger\n"'
bind '"\C-n":"newsboat\n"'
bind '"\C-s":"ranger /home/dyntif/school/eerste-bach/tweede-semester\n"'
bind '"\C-v":"vim /home/dyntif/"'

bind 'set editing-mode vi'
bind '"qj":vi-movement-mode'

alias la='ls -la'
alias cb='cd ..'
alias e='exit'


#  MIjn prachtige lente cleanup zonder bash_profile
[[ -f ~/.config/env  ]] && . ~/.config/env

