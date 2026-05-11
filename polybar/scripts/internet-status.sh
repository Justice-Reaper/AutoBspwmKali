#!/bin/bash

default_interface=$(ip route show default | sort -k 11 -n | head -1 | awk '{print $5}')

if [ -n "$default_interface" ]; then
    ip_address=$(ip addr show "$default_interface" | awk '/inet / {print $2}' | cut -d'/' -f1)

    case "$default_interface" in
        wl*) icon="%{F#70A5EB}󰤢" ;;
        *)   icon="%{F#70A5EB}󰈀" ;;
    esac
fi

if [ -z "$ip_address" ]; then
    ip_address="Disconnected"
    icon="%{F#70A5EB}󱘖"
fi

echo " $icon %{F#DEE1E6}$ip_address"
