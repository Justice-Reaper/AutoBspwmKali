#!/bin/bash

dir="/home/user_replace/.config/rofi/power-menu"
host="Kali Linux"
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout=' Logout'

focused_border=$(bspc config focused_border_color)
active_border=$(bspc config active_border_color)
normal_border=$(bspc config normal_border_color)
bspc config focused_border_color "$normal_border"
bspc config active_border_color "$normal_border"

rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -theme "${dir}/style.rasi"
}

run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
    if [[ $1 == '--shutdown' ]]; then
        systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
        systemctl reboot
    elif [[ $1 == '--suspend' ]]; then
        systemctl suspend
    elif [[ $1 == '--logout' ]]; then
        bspc quit
    fi
    exit 0
}

chosen="$(run_rofi)"

bspc config focused_border_color "$focused_border"
bspc config active_border_color "$active_border"

case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        betterlockscreen -q --lock blur
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
