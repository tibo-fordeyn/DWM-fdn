#!/bin/bash

# dmenu menu van kleuren.txt tonen, 
# het stuk na # weergeven, het stuk voor # grijpen voor gebruik
chosen=$(cut -d '#' -f 2 ~/dl/themas/scripts/afbeeldingen | dmenu -l 17)
[ -z "$chosen" ] && exit

# Toon het dmenu-menu van kleuren.txt, 
# het stuk na # weergeven, het stuk voor # gebruiken voor gebruik

if [ "$chosen" = "Kies" ]; then
    # Verwijder het bestaande gekozen bestand
    rm -f ~/dl/themas/scripts/chosen
    # Start sxiv in thumbnail-modus
    sxiv -t /pad/naar/afbeeldingen
    # Wacht tot sxiv afsluit
    # Lees het pad van de gekozen afbeelding uit het bestand
    snippet=$(cat ~/dl/themas/scripts/chosen)
    [ -z "$snippet" ] && exit
else
    snippet=$(grep "$chosen" ~/dl/themas/scripts/afbeeldingen | cut -d '#' -f 1)
fi

# Voer wal uit met de gekozen afbeelding
wal -i "$snippet"



# wal -i {plak hier het  pad dat wordt gekozen uit kleuren.txt} 
# noot dat er geen '&' wordt gebruikt zodat het proces pas
# wordt verdergezet wanneer het commando volledig is uitgevoerd.
wal -i $snippet

# het zou misschien geen slecht idee zijn om alle 
# terminals te sluiten nadat dit is uitgevoerd.
# deze herladen hun kleuren niet vanzelf 
# altans bij mij toch niet

# hercompilleren voor dmenu en dwm
/home/dyntif/dl/themas/scripts/append-dmenu.sh
cd /home/dyntif/suckless/dmenu 
sudo make clean install 

#/home/dyntif/.cache/wal/append-dwm.sh
cd /home/dyntif/suckless/dwm 
sudo make clean install  #| grep -v -E "warning|note"
# ik probeer hier om de warnings enzo een beetje te verbergen, zo kan ik beter
# zien wat er aan het gebeuern is wanneer ik dit script test
pkill -HUP dwm & # het herladen van dwm na hercompilleren
# dit vereist de restartsig patch of zoiets

# kijk eens of je een manier kunt vinden om ctrl tab te behouden

# de terminal kleuren gebeuren automatisch, gegeven dat je 
# st en bash gebruikt, en je enkele patches en configs hebt 
# toegevoegd voor het gebruiken van Xrecourses


# andere programma's
zathura-pywal -a 0.9 &
pywalfox update &
# dunst kleuren
/home/dyntif/dl/themas/scripts/dunstwal.sh


# rog leds op toetsenbord
leadcol=$(head -n 2 ~/.cache/wal/colors | tail -n 1 | tr -d '#')
rogauracore single_static "$leadcol"
# noot: neemt het kleur na de tweede #, en dat kleur gebruikt het 
#

dunstify -u high -t 4000 "Thema" "Je thema is veranderd naar${chosen}"

