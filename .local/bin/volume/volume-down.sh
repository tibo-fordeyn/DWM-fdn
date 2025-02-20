#!/bin/bash

# Verlaag het volume met 5%
pactl set-sink-volume @DEFAULT_SINK@ -5%

# Lees daarna het nieuwe volume uit van de default sink
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ \
         | grep -m1 -oE '[0-9]+%' \
         | head -n1 \
         | tr -d '%')

# Toon een melding met dunst
dunstctl close-all
dunstify -u high -t 1000 -i ~/.local/bin/images/volume-down.png "Volume -" "New Volume: ${VOLUME}%"
