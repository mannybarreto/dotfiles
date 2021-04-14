#!/bin/bash

startxfce4 &

if pgrep -x "xfwm4" > /dev/null
then
	killall xfwm4
fi


sxhkd &
picom &
conky &
. "${HOME}/.config/bspwm/colors.sh"

#Other application can be added here to autostart
