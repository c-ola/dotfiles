#!/bin/bash

entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

selected=$(echo -e $entries|wofi --conf ~/.config/wofi/powermenuconf --style ~/.config/wofi/style.css --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    hyprctl dispatch exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
