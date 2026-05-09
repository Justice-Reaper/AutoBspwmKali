#!/bin/bash

direction="$1"

step=50

case "$direction" in
    west)  bspc node -z left -"$step" 0 ;;
    east)  bspc node -z right "$step" 0 ;;
    north) bspc node -z top 0 -"$step" ;;
    south) bspc node -z bottom 0 "$step" ;;
esac
