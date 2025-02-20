#!/bin/bash

# Verhoog het volume van de default sink met 5%
pactl set-sink-volume @DEFAULT_SINK@ +5%

# Lees daarna het nieuwe volume uit
# 'pactl get-sink-volume @DEFAULT_SINK@' geeft typ. iets als:
# Volume: front-left: 40634 /  62% / -12.46 dB,   front-right: 39978 /  61% / -12.88 dB
# We halen gewoon het eerste percentage (front-left) eruit:

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ \
         | grep -m1 -oE '[0-9]+%' \
         | head -n1 \
         | tr -d '%')

# Dunst melding
dunstctl close-all
dunstify -u high -t 1000 -i ~/.local/bin/images/volume-up.png "Volume +" "New Volume: ${VOLUME}%"
