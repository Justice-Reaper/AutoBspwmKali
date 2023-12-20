#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme='style'

# CMDs
host=`hostname`

# Options
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout=' Logout'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$host" \
		-theme ${dir}/${theme}.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
	elif [[ $1 == '--suspend' ]]; then
		mpc -q pause
		amixer set Master mute
		systemctl suspend
	elif [[ $1 == '--logout' ]]; then
		bspc quit
	fi

	exit 0
}

# Actions
chosen="$(run_rofi)"
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
