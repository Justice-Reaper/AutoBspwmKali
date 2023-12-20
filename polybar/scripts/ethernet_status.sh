#!/bin/sh

IFACE_ETH0=$(ip addr show eth0 | grep "state UP" -A2 | awk '/inet / {print $2}' | cut -d'/' -f1)
IFACE_WLAN0=$(ip addr show wlan0 | grep "state UP" -A2 | awk '/inet / {print $2}' | cut -d'/' -f1)

if [ -n "$IFACE_ETH0" ]; then
    IP_ADDRESS="$IFACE_ETH0"
    ICON="%{F#70A5EB}󰈀"  # Icono para eth0
elif [ -n "$IFACE_WLAN0" ]; then
    IP_ADDRESS="$IFACE_WLAN0"
    ICON="%{F#70A5EB}󰤢"  # Icono para wlan0
else
    IP_ADDRESS="Disconnected"
    ICON="%{F#70A5EB}󱘖"  # Icono predeterminado
fi

echo "$ICON %{F#DEE1E6}$IP_ADDRESS%{u-}"
