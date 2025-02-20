#!/bin/bash

# Definieer de symlink locatie
symlink_path=~/school/current-subject

# Toon alleen de naam van de hoogste directory in een melding, zonder extra tekst
if [[ -L "$symlink_path" ]]; then
    current_subject=$(basename "$(readlink -f "$symlink_path")")
    notify-send -t 3000 "$current_subject"
fi

# Toon alle submappen in de directory ~/school/tweede-bach/eerste-sem/ in dmenu en sla de keuze op
chosen_subject=$(find ~/school/tweede-bach/tweede-sem/ -maxdepth 1 -mindepth 1 -type d | sed 's|.*/||' | dmenu -p "Select subject:")

# Controleer of een keuze is gemaakt en verschilt van de huidige symlink
if [[ -n "$chosen_subject" && "$chosen_subject" != "$current_subject" ]]; then
    # Verwijder bestaande symlink als die er is
    rm -f "$symlink_path"

    # Maak een nieuwe symlink naar het gekozen vak, zonder onnodige whitespace of aanhalingstekens
    ln -s ~/school/tweede-bach/tweede-sem/"$chosen_subject" "$symlink_path"
    
    # Stuur een melding met de naam van het nieuwe vak
    notify-send -t 3000 "$chosen_subject"

    # Ga naar de nieuwe symlink directory en start inkscape-figures watch
    cd "$symlink_path" && inkscape-figures watch &
fi
