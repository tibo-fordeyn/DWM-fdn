# ~/.bashrc

# Neofetch uitschakelen of inschakelen
neofetch

# Algemene modes
set -o vi

PS1='\[\e[32m\]\u:\W \$\[\e[m\] '


# Shortcuts en belangrijke commando's
# merk op dat als je sommige toetsen bindt, het niet werkt of je hele terminal
# breekt. Ik weet niet echt waarom.
bind '"\C-l":"clear\n"'
bind '"\C-r":"ranger\n"'
bind '"\C-n":"~/.config/newsboat/newsboat-wrapper.sh\n"'
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
alias p='python3'
alias newsboat="~/.config/newsboat/newsboat-wrapper.sh"
alias serv='ssh -t dyntif@192.168.0.249'
alias rpiserv='ssh -t dyntif@192.168.0.102'
alias discord='flatpak run com.discordapp.Discord'

#scp input dyntif@192.168.0.249:output
#alias vidmn='sshfs dyntif@192.168.0.249:/home/dyntif/superfiles/problematisnoi ~/persoonlijk/superfiles/problematisnoi || echo "Server niet bereikbaar"'

# dagboek aliasses
alias dgbk='~/.local/bin/superfiles/weekboek.sh'
alias idd='~/.local/bin/superfiles/idee.sh'
# gebruik idee uit die yt video om laatste bestand te vinden en schrijf report script

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

