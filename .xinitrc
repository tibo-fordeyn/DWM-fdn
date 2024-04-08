#!/bin/sh

dwmblocks &
unclutter -idle 0.5 &
xset s off -dpms &
picom &

exec 2>/home/dyntif/.cache/xsession-errors
exec dwm
