#!/bin/bash

# Definieer het pad naar het configuratiebestand
CONFIG_FILE="/home/dyntif/.cache/wal/colors-wal-dmenu.h"

# De regels die je wilt toevoegen
LINE1='    	[SchemeNormHighlight] = { "#ffffff", "#333333" },  // Dit is met een apart script ingevoerd, kan ook door wal broncode te veranderen, maar dat veroorzaakt te veel problemen.'
LINE2='    	[SchemeSelHighlight] = { "#ffffff", "#005577" },   '

# Controleer of het bestand bestaat
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuratiebestand niet gevonden op $CONFIG_FILE"
    exit 1
fi

# Controleer of de regels al aanwezig zijn
if grep -q "SchemeNormHighlight" "$CONFIG_FILE"; then
    echo "Highlight regels zijn al aanwezig in het configuratiebestand."
else
    # Voeg de regels toe vlak voor de laatste regel van het bestand
    echo "Regels toevoegen aan het configuratiebestand."
    # Maak een tijdelijk bestand
    TEMP_FILE=$(mktemp)
    
    # Voeg alle regels toe behalve de laatste
    head -n -1 "$CONFIG_FILE" > "$TEMP_FILE"
    
    # Voeg de nieuwe regels toe
    echo "$LINE1" >> "$TEMP_FILE"
    echo "$LINE2" >> "$TEMP_FILE"
    
    # Voeg de oorspronkelijke laatste regel toe
    tail -n 1 "$CONFIG_FILE" >> "$TEMP_FILE"
    
    # Vervang het originele bestand met het tijdelijke bestand
    mv "$TEMP_FILE" "$CONFIG_FILE"
    
    echo "Regels succesvol toegevoegd."
fi
