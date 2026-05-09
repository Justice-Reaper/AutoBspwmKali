#!/bin/bash

max_brightness=$(brightnessctl -q m)
current_brightness=$(cat /sys/class/backlight/*/brightness)
brightness_percentage=$((current_brightness * 100 / max_brightness))
new_brightness=$((brightness_percentage - 10))

brightnessctl -q s "$new_brightness%"

cat /sys/class/backlight/*/brightness
