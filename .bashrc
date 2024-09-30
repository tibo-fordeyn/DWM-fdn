# ~/.bashrc

# Neofetch uitschakelen of inschakelen
# neofetch

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
#PS1='\[$background_color\] \w \[$reset_color\]\$ \[$foreground_color\]'
#PS1=' \[\e[1;32m\]\W\[\e[0m\] \$ '
PS1='\[\e[32m\]\u:\W \$\[\e[m\] '


# Shortcuts en belangrijke commando's
# merk op dat als je sommige toetsen bindt, het niet werkt of je hele terminal
# breekt. Ik weet niet echt waarom, moet je eens naar kijken.
bind '"\C-l":"clear\n"'
bind '"\C-r":"ranger\n"'
bind '"\C-n":"newsboat\n"'
# enkele belangrijke terminal dingen
bind '"\C-g":"| xclip -selection clipboard -i\C-m"'
bind '"\C-v":"ranger /home/dyntif/school/current-subject\n"'
bind '"\C-p":"xclip -selection clipboard -o > "'

bind 'set editing-mode vi'
bind '"qj":vi-movement-mode'

alias la='ls -la'
alias cb='cd ..'
alias cbh='cd ~'
alias e='exit'
alias v='vim'
alias no='vim ~/dl/notebooks/notes/notes.md'
alias r='ranger'
alias p='python3'
alias trrm='rm natuurkunde-gevat.aux natuurkunde-gevat.fdb_latexmk natuurkunde-gevat.fls natuurkunde-gevat.log natuurkunde-gevat.pdf natuurkunde-gevat.toc'

# don't have nested ranger instances
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

#  MIjn prachtige lente cleanup zonder bash_profile
[[ -f ~/.config/env  ]] && . ~/.config/env

