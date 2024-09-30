#!/bin/bash

PID_FILE="/home/dyntif/.local/bin/timer_focus.pid"

# Check of Timewarrior momenteel een timer heeft lopen
if timew | grep -q 'There is no active time tracking.'; then
    # Geen actieve timer, start een nieuwe sessie
    timew start "studeren" "herexamens"
    dunstify "Timewarrior" "Timer gestart! Ga ervoor!"
    echo "⚠   Timew telt !!                              " > ~/suckless/dwmblocks/whitespace.txt


    /home/dyntif/.local/bin/timer_focus.sh
    
else
    # Er is een actieve timer, stop deze
    timew stop
    dunstify "Timewarrior" "Timer gestopt! Hoop dat je goed gewerkt hebt!"
    echo "❤ Succes vandaag                               " > ~/suckless/dwmblocks/whitespace.txt

    if [ -f "$PID_FILE" ]; then
        kill $(cat "$PID_FILE")
        rm "$PID_FILE"
    fi

fi
