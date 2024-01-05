#!/bin/sh

interfaces=$(ifconfig -a | grep '^[a-zA-Z]' | awk '{print $1}' | sed 's/://')

ip_address=""
icon=""

for interface in $interfaces; do
    if echo "$interface" | grep -q "wl"; then
        ip_address=$(ip addr show $interface | awk '/inet / {print $2}' | cut -d'/' -f1)
        icon="%{F#70A5EB}󰈀"
    elif echo "$interface" | grep -q "en\|eth"; then
        ip_address=$(ip addr show $interface | awk '/inet / {print $2}' | cut -d'/' -f1)
        icon="%{F#70A5EB}󰤢"
    else
        ip_address="Disconnected"
        icon="%{F#70A5EB}󱘖"
    fi
done

echo "$icon %{F#DEE1E6}$ip_address%{u-}"
