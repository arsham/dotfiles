#!/bin/bash
json_format='{"alt":"%s","tooltip":"%s"}\n'
fancy_msg="Animations are very fancy"
normal_msg="Animations are enabled and normal"
disabled_msg="Animations are disabled"
msg=$fancy_msg

# enabled=$(hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')

state=$(cat /home/arsham/tmp/hyprland.animations.state)
next_state="normal"

if [ "$1" = "init" ]; then
	msg="Animations"
	printf "$json_format" "$state" "$msg"
	exit
fi

if [ "$state" = "normal" ]; then
	echo "disabled" >/home/arsham/tmp/hyprland.animations.state
	msg=$disabled_msg
	next_state="disabled"
elif [ "$state" = "disabled" ]; then
	echo "fancy" >/home/arsham/tmp/hyprland.animations.state
	msg=$fancy_msg
	next_state="fancy"
else
	echo "normal" >/home/arsham/tmp/hyprland.animations.state
	msg=$normal_msg
	next_state="normal"
fi

if [ "$next_state" = "disabled" ]; then
	hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword animation borderangle,0,30,linear,loop;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0; \
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword decoration:inactive_opacity 1.0"
elif [ "$next_state" = "normal" ]; then
	# keyword general:gaps_in 5;\
	# keyword general:gaps_out 5;\
	hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword animation borderangle,0,30,linear,loop;\
        keyword decoration:drop_shadow 1;\
        keyword decoration:blur:enabled 1;\
        keyword general:border_size 3;\
        keyword decoration:rounding 5;\
        keyword general:gaps_in 8;\
        keyword general:gaps_out 16;\
        keyword decoration:inactive_opacity 0.95"
elif [ "$next_state" = "fancy" ]; then
	# keyword general:gaps_in 5;\
	# keyword general:gaps_out 5;\
	hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword animation borderangle,1,30,linear,loop;\
        keyword decoration:drop_shadow 1;\
        keyword decoration:blur:enabled 1;\
        keyword general:border_size 3;\
        keyword decoration:rounding 10;\
        keyword general:gaps_in 8;\
        keyword general:gaps_out 16;\
        keyword decoration:inactive_opacity 0.95"
fi

# hyprctl notify -1 2000 "rgb(ff1ea3)" "$msg"
msg="Animations"
printf "$json_format" "$next_state" "$msg"
