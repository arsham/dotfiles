#!/usr/bin/zsh
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done

unset GDK_SCALE
unset GDK_DPI_SCALE
polybar -c ~/.config/polybar/config_laptop.ini arsham
