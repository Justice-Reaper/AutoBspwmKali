#!/bin/bash

label="%{F#E784A7}󰃠"
bar_width=10
bar_fill="━"
bar_empty="━"
color_fill="#E784A7"
color_empty="#DEE1E6"

brightness=$(cat /sys/class/backlight/*/brightness)
max_brightness=$(cat /sys/class/backlight/*/max_brightness)

percent=$(( brightness * 100 / max_brightness ))

filled=$(( bar_width * percent / 100 ))
empty=$(( bar_width - filled ))
bar=""

for ((i = 0; i < filled; i++)); do
  bar+="%{F$color_fill}$bar_fill"
done

for ((i = 0; i < empty; i++)); do
  bar+="%{F$color_empty}$bar_empty"
done

echo -e "$label $bar"
