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

if [ "$battery_level" -le "$warning_level" ] && [ "$(cat $battery_warning_file)" != "True" ]; then
    notify-send "Low Battery" "${battery_level}% of battery remaining" -u critical -i "battery-alert" -r 9991
    echo 'True' > "$battery_warning_file"
    echo 'False' > "$battery_charging_file"
    echo 'False' > "$battery_discharging_file"
    echo 'False' > "$battery_fully_charged_file"

elif [ "$battery_discharging" -eq 1 ] && [ "$(cat $battery_discharging_file)" != "True" ] && [ "$battery_level" -le 99 ]; then
    echo 'True' > "$battery_discharging_file"
    echo 'False' > "$battery_warning_file"
    echo 'False' > "$battery_fully_charged_file"
    echo 'False' > "$battery_charging_file"

elif [ "$battery_charging" -eq 1 ] && [ "$(cat $battery_charging_file)" != "True" ] && [ "$battery_level" -le 99 ]; then
    notify-send "Charging" "${battery_level}% of battery charged" -u normal -i "battery-charging" -r 9991
    echo 'True' > "$battery_charging_file"
    echo 'False' > "$battery_warning_file"
    echo 'False' > "$battery_fully_charged_file"
    echo 'False' > "$battery_discharging_file"

elif [ "$battery_level" -eq 100 ] && [ "$(cat $battery_fully_charged_file)" != "True" ]; then
    echo 'True' > "$battery_fully_charged_file"
    echo 'False' > "$battery_charging_file"
    echo 'False' > "$battery_warning_file"
    echo 'False' > "$battery_discharging_file"
    notify-send "Battery Charged" "Battery is fully charged" -u normal -i "battery-fully-charged" -r 9991
fi
