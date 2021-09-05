#!/usr/bin/zsh

icon=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

str=""
# red=#CD1F3F
# green=#A3D770
red=#CD1F3F
green=#37630B

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l ); then
    updates_aur=0
fi

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if [ $updates_aur -gt 0 ]; then
    str+=%{F$red}$updates_aur%{F-}
    notify-send -u normal -i $icon \
        "$updates_aur New AUR packages"
else
    str+=%{F$green}0%{F-}
fi
str+="  "

if [ $updates_arch -gt 0 ]; then
    str+=%{F$red}$updates_arch%{F-}
    notify-send -u normal -i $icon \
        "$updates_arch New Arch packages"
else
    str+=%{F$green}0%{F-}
fi

echo $str
