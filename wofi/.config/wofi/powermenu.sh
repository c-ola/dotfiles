#!/usr/bin/env bash

op=$( echo -e "    Poweroff\n    Reboot\n  Suspend\n  Lock\n  Logout" | wofi -i --dmenu | awk '{print tolower($2)}' )

case $op in 
        poweroff)
		systemctl poweroff -i ;;
        reboot)
		systemctl reboot ;;
        suspend)
                systemctl suspend ;;
        #lock)
	#	hyprlock ;;
        logout)
                hyprctl dispatch exit ;;
esac
