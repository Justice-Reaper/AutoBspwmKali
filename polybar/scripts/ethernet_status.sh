#!/bin/sh

interfaces=$(ip -o link show | awk -F': ' '{print $2}')

wifi_interface=""
ethernet_interface=""

for interface in $interfaces; do
    if echo "$interface" | grep -q "wl"; then
        wifi_interface=$interface
        icon="%{F#70A5EB}󰤢"

    elif echo "$interface" | grep -q "en\|eth"; then
        ethernet_interface=$interface
        icon="%{F#70A5EB}󰈀"
    fi
done

ip_address=""
icon=""

if [ -n "$wifi_interface" ]; then
    ip_address=$(ip addr show $wifi_interface | awk '/inet / {print $2}' | cut -d'/' -f1)
    icon="%{F#70A5EB}󰤢"
fi

if [ -n "$ethernet_interface" ]; then
    ip_address=$(ip addr show $ethernet_interface | awk '/inet / {print $2}' | cut -d'/' -f1)
    icon="%{F#70A5EB}󰈀"
fi

if [ -z "$wifi_interface" ] && [ -z "$ethernet_interface" ]; then
    ip_address="Disconnected"
    icon="%{F#70A5EB}󱘖"
fi

echo "$icon %{F#DEE1E6}$ip_address%{u-}"
