#!/bin/bash

# Deblokkeer YouTube
~/.config/newsboat/unblock-yt.sh &

# Wacht 10 seconden en blokkeer YouTube opnieuw, los van Newsboat
(sleep 10 && ~/.config/newsboat/unblock-yt.sh) &

# Start Newsboat
newsboat
