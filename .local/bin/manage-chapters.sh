#!/bin/bash

# Controleer of een bestandsnaam is opgegeven
if [ $# -lt 1 ]; then
    echo "Gebruik: $0 bestandsnaam.tex"
    exit 1
fi

bestand="$1"

# Controleer of het bestand bestaat
if [ ! -f "$bestand" ]; then
    echo "Bestand niet gevonden: $bestand"
    exit 1
fi

# Lees het bestand in een array
mapfile -t lijnen < "$bestand"

# Initialiseer variabelen
declare -a hoofdstuk_start
declare -a hoofdstuk_eind
declare -a hoofdstuk_titel
hoofdstuk_teller=0

# Doorloop de lijnen om hoofdstukken te vinden
for ((i=0; i<${#lijnen[@]}; i++)); do
    regel="${lijnen[i]}"
    # Verwijder leidende en afsluitende spaties
    regel="$(echo "$regel" | sed 's/^[ \t]*//;s/[ \t]*$//')"
    if [[ "$regel" =~ ^\\chapter\{.*\} ]]; then
        # Hoofdstuk gevonden
        hoofdstuk_start[hoofdstuk_teller]=$i
        # Haal de titel op
        titel="$(echo "$regel" | sed 's/\\chapter{\(.*\)}/\1/')"
        hoofdstuk_titel[hoofdstuk_teller]="$titel"
        if [ $hoofdstuk_teller -gt 0 ]; then
            # Stel het eind van het vorige hoofdstuk in
            hoofdstuk_eind[$((hoofdstuk_teller-1))]=$((i-1))
        fi
        hoofdstuk_teller=$((hoofdstuk_teller+1))
    elif [[ "$regel" =~ ^\\end\{document\} ]]; then
        # Einde van het document
        if [ $hoofdstuk_teller -gt 0 ]; then
            hoofdstuk_eind[$((hoofdstuk_teller-1))]=$((i-1))
        fi
        break
    fi
done

# Als het laatste hoofdstuk geen eind heeft, stel het dan in op het einde van het document
if [ ${#hoofdstuk_eind[@]} -lt ${#hoofdstuk_start[@]} ]; then
    hoofdstuk_eind[$((hoofdstuk_teller-1))]=$(( ${#lijnen[@]} - 1 ))
fi

# Bouw het menu voor dmenu
menu=""
for ((i=0; i<hoofdstuk_teller; i++)); do
    h=$((i+1))
    menu+="H$h - ${hoofdstuk_titel[i]}\n"
done

# Toon het menu en haal de selectie op
selectie=$(echo -e "$menu" | dmenu -i -p "Selecteer Hoofdstuk:")

# Controleer of er een selectie is gemaakt
if [ -z "$selectie" ]; then
    exit 0
fi

# Controleer op '!' aan het einde van de selectie
if [[ "$selectie" =~ !\s*$ ]]; then
    inversie=1
    # Verwijder '!' van de selectie
    selectie="${selectie%!}"
else
    inversie=0
fi

# Haal het geselecteerde hoofdstuknummer op
hoofdstuk_geselecteerd=$(echo "$selectie" | sed 's/^H\([0-9]*\).*/\1/')
index=$((hoofdstuk_geselecteerd - 1))

# Maak een array met alle hoofdstukindexen
hoofdstuk_indices=()
for ((i=0; i<hoofdstuk_teller; i++)); do
    hoofdstuk_indices+=($i)
done

if [ $inversie -eq 1 ]; then
    # Inverseer de selectie: bewerk alle hoofdstukken behalve het geselecteerde
    bewerk_indices=()
    for i in "${hoofdstuk_indices[@]}"; do
        if [ $i -ne $index ]; then
            bewerk_indices+=($i)
        fi
    done
    # Voer de toggle-operatie uit op alle andere hoofdstukken
    for idx in "${bewerk_indices[@]}"; do
        start_lijn=${hoofdstuk_start[idx]}
        eind_lijn=${hoofdstuk_eind[idx]}
        
        # Controleer of het hoofdstuk is uitgecommentarieerd
        volgende_regel="${lijnen[$((start_lijn+1))]}"
        if [[ "$volgende_regel" =~ ^% ]]; then
            actie="decomment"
        else
            actie="comment"
        fi
        
        # Commentarieer of de-commentarieer de lijnen tussen start en eind
        for ((i=start_lijn+1; i<=eind_lijn; i++)); do
            regel="${lijnen[i]}"
            if [ "$actie" == "decomment" ]; then
                # De-commentarieer
                lijnen[i]="$(echo "$regel" | sed 's/^%[ ]*//')"
            else
                # Commentarieer
                lijnen[i]="% ${regel}"
            fi
        done
    done
else
    # Bewerk alleen het geselecteerde hoofdstuk
    start_lijn=${hoofdstuk_start[index]}
    eind_lijn=${hoofdstuk_eind[index]}
    
    # Controleer of het hoofdstuk is uitgecommentarieerd
    volgende_regel="${lijnen[$((start_lijn+1))]}"
    if [[ "$volgende_regel" =~ ^% ]]; then
        actie="decomment"
    else
        actie="comment"
    fi
    
    # Commentarieer of de-commentarieer de lijnen tussen start en eind
    for ((i=start_lijn+1; i<=eind_lijn; i++)); do
        regel="${lijnen[i]}"
        if [ "$actie" == "decomment" ]; then
            # De-commentarieer
            lijnen[i]="$(echo "$regel" | sed 's/^%[ ]*//')"
        else
            # Commentarieer
            lijnen[i]="% ${regel}"
        fi
    done
fi

# Maak een back-up van het originele bestand
cp "$bestand" "${bestand}.bak"

# Schrijf de gewijzigde lijnen terug naar het bestand
printf "%s\n" "${lijnen[@]}" > "$bestand"
