#!/bin/bash

dir="/home/user_replace/.config/rofi/launcher"

focused_border=$(bspc config focused_border_color)
active_border=$(bspc config active_border_color)
normal_border=$(bspc config normal_border_color)
bspc config focused_border_color "$normal_border"
bspc config active_border_color "$normal_border"

rofi \
    -show drun \
    -theme "${dir}/style.rasi"

bspc config focused_border_color "$focused_border"
bspc config active_border_color "$active_border"
