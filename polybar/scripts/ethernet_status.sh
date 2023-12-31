#!/bin/sh

IFACE_ETHERNET=$(ip addr show ethernet_replace | grep "state UP" -A2 | awk '/inet / {print $2}' | cut -d'/' -f1)
IFACE_WIFI=$(ip addr show wifi_replace | grep "state UP" -A2 | awk '/inet / {print $2}' | cut -d'/' -f1)

if [ -n "$IFACE_ETHERNET" ]; then
    IP_ADDRESS="$IFACE_ETHERNET"
    ICON="%{F#70A5EB}󰈀"  # Icono para eth0
elif [ -n "$IFACE_WIFI" ]; then
    IP_ADDRESS="$IFACE_WIFI"
    ICON="%{F#70A5EB}󰤢"  # Icono para wlan0
else
    IP_ADDRESS="Disconnected"
    ICON="%{F#70A5EB}󱘖"  # Icono predeterminado
fi

echo "$ICON %{F#DEE1E6}$IP_ADDRESS%{u-}"
