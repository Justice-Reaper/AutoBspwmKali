#!/bin/sh

IFACE_ETHERNET=$(ip addr show ethernet_replace | awk '/inet / {print $2}' | cut -d'/' -f1)
IFACE_WIFI=$(ip addr show wifi_replace | awk '/inet / {print $2}' | cut -d'/' -f1)

if [ -n "$IFACE_ETHERNET" ]; then
    IP_ADDRESS="$IFACE_ETHERNET"
    ICON="%{F#70A5EB}󰈀" 
elif [ -n "$IFACE_WIFI" ]; then
    IP_ADDRESS="$IFACE_WIFI"
    ICON="%{F#70A5EB}󰤢"
else
    IP_ADDRESS="Disconnected"
    ICON="%{F#70A5EB}󱘖"
fi

echo "$ICON %{F#DEE1E6}$IP_ADDRESS%{u-}"
