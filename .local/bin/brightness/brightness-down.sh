#!/bin/bash

# Bestand voor opslag van huidige helderheidswaarde
BRIGHTNESS_FILE="$HOME/.local/bin/brightness/current-brightness"


# Krijg lijst van aangesloten monitoren
MONITORS=$(xrandr --query | grep " connected" | awk '{ print $1 }')

# Functie om helderheid te verlagen
decrease_brightness() {
    # Lees huidige helderheid, standaard op 1.0 als het bestand niet bestaat
    if [ -f $BRIGHTNESS_FILE ]; then
        CURRENT_BRIGHTNESS=$(cat $BRIGHTNESS_FILE)
    else
        CURRENT_BRIGHTNESS=1.0
    fi

    # Verlaag helderheid met 0.1
    NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS - 0.1" | bc)

    # Beperk de helderheid tot minimaal 0.0
    if (( $(echo "$NEW_BRIGHTNESS < 0.0" | bc -l) )); then
        NEW_BRIGHTNESS=0.0
    fi

    # Sla de nieuwe helderheid op
    echo $NEW_BRIGHTNESS > $BRIGHTNESS_FILE

    # Pas de nieuwe helderheid toe op alle monitoren
    for MONITOR in $MONITORS; do
        xrandr --output $MONITOR --brightness $NEW_BRIGHTNESS
    done
}
decrease_brightness
dunstctl close-all
dunstify -u high -t 1000 -i "$HOME/.local/bin/images/brightness-down.png" "Brightness -" "New Brightness: $NEW_BRIGHTNESS"

# Aanpassen toetsenbordverlichting
kb_brightness=$(echo "$NEW_BRIGHTNESS * 3" | bc)
if (( $(echo "$kb_brightness < 1" | bc -l) )); then
    rogauracore brightness 0
elif (( $(echo "$kb_brightness < 2" | bc -l) )); then
    rogauracore brightness 1
elif (( $(echo "$kb_brightness < 3" | bc -l) )); then
    rogauracore brightness 2
else
    rogauracore brightness 3
fi



