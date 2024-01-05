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

if [ -n "$ethernet_interface" ]; then
    ip_address=$(ip addr show $ethernet_interface | awk '/inet / {print $2}' | cut -d'/' -f1)

elif [ -n "$wifi_interface" ]; then
    ip_address=$(ip addr show $wifi_interface | awk '/inet / {print $2}' | cut -d'/' -f1)
fi

echo -n "$ip_address" | xclip -sel clip
