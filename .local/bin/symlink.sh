#!/bin/bash

# Ga naar de directory met de vakken
cd ~/school/tweede-bach/eerste-sem/ || exit

# Toon alle submappen in dmenu en sla de keuze op
chosen_subject=$(find . -maxdepth 1 -type d -not -name '.' -exec basename {} \; | dmenu -p "HUIDIG VAK SYMLINK:")

# Controleer of een keuze is gemaakt
if [[ -n "$chosen_subject" ]]; then
    # Verwijder bestaande symlink als die er is
    rm -f ~/school/current-subject

    # Maak een nieuwe symlink naar het gekozen vak
    ln -s ~/school/tweede-bach/eerste-sem/"$chosen_subject" ~/school/current-subject
    echo "Symlink created for $chosen_subject."
else
    echo "No subject selected."
fi
