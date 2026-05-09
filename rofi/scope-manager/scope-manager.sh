#!/bin/bash

FILE="/home/user_replace/.config/bin/scope"
DIR="/home/user_replace/.config/rofi/scope-manager"
MIN_WIDTH=250

focused_border=$(bspc config focused_border_color)
active_border=$(bspc config active_border_color)
normal_border=$(bspc config normal_border_color)
bspc config focused_border_color "$normal_border"
bspc config active_border_color "$normal_border"

mapfile -t domains < <(grep '[^[:space:]]' "$FILE" 2>/dev/null | sort -u)
assets="${#domains[@]}"

[[ "$assets" -eq 0 ]] && exit 0

max=$(printf '%s\n' "${domains[@]}" | awk 'length > max { max = length } END { print max }')
width=$(( max * 14 ))
[[ "$width" -lt "$MIN_WIDTH" ]] && width="$MIN_WIDTH"

selection=$(printf '%s\n' "${domains[@]}" | rofi \
  -dmenu \
  -p "" \
  -theme "${DIR}/style.rasi" \
  -theme-str "window { width: ${width}px; }"
)

bspc config focused_border_color "$focused_border"
bspc config active_border_color "$active_border"

[[ -n "$selection" ]] && printf '%s' "$selection" | xclip -sel clip
