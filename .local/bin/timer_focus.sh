#!/bin/bash

# Pad naar het PID bestand
PID_FILE="/home/dyntif/.local/bin/timer_focus.pid"
echo $$ > "$PID_FILE"

# Drempel voor inactiviteit in milliseconden (30 minuten)
INACTIVITY_THRESHOLD=$((30 * 60 * 1000))

# Begin met het controleren van de inactiviteit
while true; do
    # Controleer de inactiviteitstijd met xprintidle
    IDLE_TIME=$(xprintidle)
    
    # Bereken de resterende tijd voordat de drempel wordt bereikt
    REMAINING_TIME=$((INACTIVITY_THRESHOLD - IDLE_TIME))

    if [[ "$REMAINING_TIME" -le 0 ]]; then
        # Stop de Timewarrior timer door het toggle script aan te roepen
    	timew stop
	dunstify "Timewarrior" "Timer gestopt! Inactiviteit :("
    	echo "❤ Succes vandaag                               " > ~/suckless/dwmblocks/whitespace.txt

        # Verwijder het PID bestand en stop dit script
        rm "$PID_FILE"
        exit 0
    else
        # Wacht de berekende resterende tijd of ten minste 1 minuut
        sleep $(( REMAINING_TIME / 1000 > 60 ? 60 : REMAINING_TIME / 1000 ))
    fi
done
