#!/bin/sh

sudo sv down connmand
sudo sv up NetworkManager
dwmblocks &
unclutter -idle 0.5 &
xset s off -dpms &
picom &
wal -R
rm .xsession-errors*
echo "1" > ~/.local/bin/brightness/current-brightness


exec dwm
