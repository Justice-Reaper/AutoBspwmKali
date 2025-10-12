#!/bin/bash

warning_level=10
battery=$(acpi | cut -d ':' -f 1)
battery_charging=$(acpi -b | grep "$battery" | grep -c "Charging")
battery_discharging=$(acpi -b | grep "$battery" | grep -c "Discharging")
battery_level=$(acpi -b | grep "$battery" | grep -P -o '[0-9]+(?=%)')

battery_discharging_file=/home/user_replace/.config/bin/battery_discharging
battery_charging_file=/home/user_replace/.config/bin/battery_charging
battery_warning_file=/home/user_replace/.config/bin/battery_warning
battery_fully_charged_file=/home/user_replace/.config/bin/battery_fully_charged

if [ "$battery_level" -le "$warning_level" ] && [ "$(cat $battery_warning_file)" != "True" ] && [ "$battery_charging" -eq 0 ]; then
    echo 'True' > "$battery_warning_file"
    echo 'False' > "$battery_charging_file"
    echo 'False' > "$battery_discharging_file"
    echo 'False' > "$battery_fully_charged_file"
    notify-send "Low Battery" "${battery_level}% of battery remaining" -c battery-critical -i "/home/user_replace/.config/dunst/icons/battery-warning.png" -r 9991

elif [ "$battery_discharging" -eq 1 ] && [ "$(cat $battery_discharging_file)" != "True" ] && [ "$battery_level" -gt 10 ] && [ "$battery_level" -le 99 ]; then
    echo 'True' > "$battery_discharging_file"
    echo 'False' > "$battery_warning_file"
    echo 'False' > "$battery_fully_charged_file"
    echo 'False' > "$battery_charging_file"

elif [ "$battery_charging" -eq 1 ] && [ "$(cat $battery_charging_file)" != "True" ] && [ "$battery_level" -le 99 ]; then
    echo 'True' > "$battery_charging_file"
    echo 'False' > "$battery_warning_file"
    echo 'False' > "$battery_fully_charged_file"
    echo 'False' > "$battery_discharging_file"
    notify-send "Charging" "${battery_level}% of battery charged" -c battery-normal -i "/home/user_replace/.config/dunst/icons/battery-charging.png" -r 9991

elif [ "$battery_level" -eq 100 ] && [ "$(cat $battery_fully_charged_file)" != "True" ]; then
    echo 'True' > "$battery_fully_charged_file"
    echo 'False' > "$battery_charging_file"
    echo 'False' > "$battery_warning_file"
    echo 'False' > "$battery_discharging_file"
    notify-send "Battery Charged" "Battery is fully charged" -c battery-normal -i "/home/user_replace/.config/dunst/icons/battery-fully-charged.png" -r 9991
fi
