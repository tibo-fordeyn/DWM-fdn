#!/bin/bash

# Pad naar het wal kleurenschema bestand
WAL_COLORS_FILE="$HOME/.cache/wal/colors"

# Lees de eerste kleur uit het wal kleurenschema
selected_color=$(sed -n '3p' $WAL_COLORS_FILE)

# Pad naar het dunst configuratiebestand
DUNST_CONFIG_FILE="$HOME/.config/dunst/dunstrc"

# Controleer of het configuratiebestand bestaat
if [ ! -f "$DUNST_CONFIG_FILE" ]; then
    echo "Configuratiebestand niet gevonden: $DUNST_CONFIG_FILE"
    exit 1
fi

# Vervang de achtergrondkleur op regel 343
sed -i "343s/background = \"#.*\"/background = \"$selected_color\"/" "$DUNST_CONFIG_FILE"

echo "Achtergrondkleur in dunstrc is bijgewerkt naar: $selected_color"

pkill dunst && dunst &
