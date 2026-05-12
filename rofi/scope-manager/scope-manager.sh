#!/bin/bash

file="/home/user_replace/.config/bin/scope"
dir="/home/user_replace/.config/rofi/scope-manager"
min_width=250
max_width=350

focused_border=$(bspc config focused_border_color)
active_border=$(bspc config active_border_color)
normal_border=$(bspc config normal_border_color)

bspc config focused_border_color "$normal_border"
bspc config active_border_color "$normal_border"

mapfile -t domains < <(grep '[^[:space:]]' "$file" 2>/dev/null | sort -u)
assets="${#domains[@]}"

[[ "$assets" -eq 0 ]] && exit 0

max=$(printf '%s\n' "${domains[@]}" | awk 'length > max { max = length } END { print max }')
width=$(( max * 14 ))

[[ "$width" -lt "$min_width" ]] && width="$min_width"
[[ "$width" -gt "$max_width" ]] && width="$max_width"

selection=$(printf '%s\n' "${domains[@]}" | rofi \
  -dmenu \
  -p "" \
  -theme "${dir}/style.rasi" \
  -theme-str "window { width: ${width}px; }"
)

bspc config focused_border_color "$focused_border"
bspc config active_border_color "$active_border"

[[ -n "$selection" ]] && printf '%s' "$selection" | xclip -sel clip
