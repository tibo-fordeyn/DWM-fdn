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

# Gebruik grep om de lijnnummers en inhoud van \chapter{...} te vinden
chapter_lines=$(grep -n '^\\chapter{' "$bestand")
end_document_line=$(grep -n '^\\end{document}' "$bestand" | cut -d: -f1)

# Als \end{document} niet gevonden is, gebruik het totale aantal regels
if [ -z "$end_document_line" ]; then
    end_document_line=$(wc -l < "$bestand")
fi

# Initialiseer arrays
declare -a hoofdstuk_start
declare -a hoofdstuk_eind
declare -a hoofdstuk_titel

# Verwerk de hoofdstukken
hoofdstuk_teller=0
prev_line=0
prev_index=0

while IFS= read -r line; do
    line_num=$(echo "$line" | cut -d: -f1)
    content=$(echo "$line" | cut -d: -f2-)
    # Haal de titel op
    titel=$(echo "$content" | sed 's/\\chapter{\(.*\)}/\1/')
    hoofdstuk_start[hoofdstuk_teller]=$line_num
    hoofdstuk_titel[hoofdstuk_teller]="$titel"
    if [ $hoofdstuk_teller -gt 0 ]; then
        hoofdstuk_eind[$prev_index]=$((line_num - 1))
    fi
    prev_line=$line_num
    prev_index=$hoofdstuk_teller
    hoofdstuk_teller=$((hoofdstuk_teller + 1))
done <<< "$chapter_lines"

# Stel het einde van het laatste hoofdstuk in
hoofdstuk_eind[$prev_index]=$((end_document_line - 1))

# Bouw het menu voor dmenu
menu=""
for ((i=0; i<hoofdstuk_teller; i++)); do
    h=$((i+1))
    menu+="H$h - ${hoofdstuk_titel[i]}\n"
done
menu+="Uncomment All Commented Chapters\n"  # Nieuwe optie toegevoegd

# Toon het menu en haal de selectie op
selectie=$(echo -e "$menu" | dmenu -i -p "Selecteer Hoofdstuk:")

# Controleer of er een selectie is gemaakt
if [ -z "$selectie" ]; then
    exit 0
fi

# Maak een back-up van het originele bestand
cp "$bestand" "${bestand}.bak"

if [[ "$selectie" == "Uncomment All Commented Chapters" ]]; then
    # De-commentarieer alle uitgecommentarieerde hoofdstukken
    for ((idx=0; idx<hoofdstuk_teller; idx++)); do
        start_lijn=${hoofdstuk_start[idx]}
        eind_lijn=${hoofdstuk_eind[idx]}

        # Controleer of het hoofdstuk is uitgecommentarieerd
        volgende_regel=$(sed -n "$((start_lijn + 1))p" "$bestand")
        if [[ "$volgende_regel" =~ ^% ]]; then
            # De-commentarieer de lijnen
            sed -i "$((start_lijn + 1)),$((eind_lijn))s/^%[ ]*//" "$bestand"
        fi
    done
    exit 0
fi

# Controleer op '!' aan het einde van de selectie
if [[ "$selectie" =~ !\s*$ ]]; then
    inversie=1
    # Verwijder '!' van de selectie
    selectie="${selectie%!*}"
else
    inversie=0
fi

# Haal het geselecteerde hoofdstuknummer op
hoofdstuk_geselecteerd=$(echo "$selectie" | sed 's/^H\([0-9]*\).*/\1/')
index=$((hoofdstuk_geselecteerd - 1))

if [ $inversie -eq 1 ]; then
    # Bewerk alle hoofdstukken
    for ((idx=0; idx<hoofdstuk_teller; idx++)); do
        start_lijn=${hoofdstuk_start[idx]}
        eind_lijn=${hoofdstuk_eind[idx]}

        if [ $idx -eq $index ]; then
            # Dit is het geselecteerde hoofdstuk
            # Controleer of het is uitgecommentarieerd
            volgende_regel=$(sed -n "$((start_lijn + 1))p" "$bestand")
            if [[ "$volgende_regel" =~ ^% ]]; then
                # Hoofdstuk is uitgecommentarieerd, decommentarieer
                sed -i "$((start_lijn + 1)),$((eind_lijn))s/^%[ ]*//" "$bestand"
            fi
            # Als het hoofdstuk al gedecommentarieerd is, doe dan niets
        else
            # Dit is een ander hoofdstuk
            # Controleer of het is uitgecommentarieerd
            volgende_regel=$(sed -n "$((start_lijn + 1))p" "$bestand")
            if [[ ! "$volgende_regel" =~ ^% ]]; then
                # Hoofdstuk is niet uitgecommentarieerd, commentarieer
                sed -i "$((start_lijn + 1)),$((eind_lijn))s/^/% /" "$bestand"
            fi
            # Als het hoofdstuk al uitgecommentarieerd is, doe dan niets
        fi
    done
else
    # Bewerk alleen het geselecteerde hoofdstuk
    start_lijn=${hoofdstuk_start[index]}
    eind_lijn=${hoofdstuk_eind[index]}

    # Controleer of het hoofdstuk is uitgecommentarieerd
    volgende_regel=$(sed -n "$((start_lijn + 1))p" "$bestand")
    if [[ "$volgende_regel" =~ ^% ]]; then
        actie="decomment"
    else
        actie="comment"
    fi

    # Voer de actie uit met sed
    if [ "$actie" == "decomment" ]; then
        sed -i "$((start_lijn + 1)),$((eind_lijn))s/^%[ ]*//" "$bestand"
    else
        sed -i "$((start_lijn + 1)),$((eind_lijn))s/^/% /" "$bestand"
    fi
fi
