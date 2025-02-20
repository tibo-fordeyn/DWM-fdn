#!/bin/bash

# Ga naar de huidige symlink directory
cd ~/school/current-subject

# Start inkscape-figures watch in de achtergrond en onderdruk uitvoer en fouten
inkscape-figures watch >/dev/null 2>&1 &

# Controleer of het Python-script al draait
if pgrep -f "python3 .*inkscape-shortcut-manager/main.py" >/dev/null 2>&1
then
    # Gebruik kortere melding met notify-send
else
    # Start het Python-script en onderdruk uitvoer en fouten
    python3 ~/.local/share/inkscape-shortcut-manager/inkscape-shortcut-manager/main.py >/dev/null 2>&1
fi
