#!/bin/sh

# standaard configs
unclutter -idle 0.5 &
xset s off -dpms &
picom -b &
wal -R
rm .xsession-errors*

# ben niet zeker of dit automatisch start
pipewire &
pipewire-pulse &
wireplumber &

# als de server is aangesloten
echo "1" > ~/.local/bin/brightness/current-brightness 
# ik weet dat het twee keer wordt uitgevoerd, weet niet waarom, voor zekerheid gewoon voor als dat onderstaand commando niet runt

( sleep 5 && COLOR=$(sed -n '2p' ~/.cache/wal/colors) && ssh -q dyntif@192.168.1.109 "~/serverscripts/achtergrond.sh '$COLOR'" ) &

( sleep 5 && echo "1" > ~/.local/bin/brightness/current-brightness && ssh -q dyntif@192.168.0.249 "~/set-brightness.sh '1'" ) &


exec dwm
