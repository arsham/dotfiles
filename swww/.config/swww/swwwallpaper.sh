#!/bin/bash
# Sets a random image as the background.

types=(simple left right top bottom wipe wave grow center any outer random)
tr_type=${types[$RANDOM % ${#types[@]}]}

poss=(center top left right bottom top-left top-right bottom-left bottom-right)
tr_pos=${poss[$RANDOM % ${#poss[@]}]}

image=$(fd . --type=f $HOME/Pictures/Wallpapers/WallPaper\ HD3/ | sort -R | head -n 1)

swww img "$image" \
	--transition-bezier .4,1.2,.5,.4 \
	--transition-type "$tr_type" \
	--transition-duration 2 \
	--transition-fps 60 \
	--transition-step 250 \
	--transition-pos "$tr_pos"
