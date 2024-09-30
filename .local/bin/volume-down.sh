#!/bin/bash

# Verlaag het volume met 5%
pactl set-sink-volume @DEFAULT_SINK@ -5%

# Haal het juiste huidige volume op
VOLUME=$(pactl list sinks | awk '/Sink #1/{flag=1;next}/Sink/{flag=0}flag' | grep '^[[:space:]]Volume:' | grep 'front-left' | awk '{print $5}' | sed 's/%//')

# Toon een melding met het nieuwe volume
dunstctl close-all
dunstify -u high -t 1000 -i ~/.local/bin/images/volume-down.png "Volume -" "New Volume: ${VOLUME}%"


