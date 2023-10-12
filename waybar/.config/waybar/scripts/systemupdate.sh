#!/usr/bin/env bash

aur=$(paru -Qua | rg -v ignored | wc -l)
official=$(pacman -Qu | wc -l)

updates=$((official + aur))

if [ $updates -ne 0 ]; then
	echo "$updates"
	printf "󱓽  Official %d \r󱓾  AUR %d" "$official" "$aur"
fi
