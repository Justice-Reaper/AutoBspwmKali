#!/bin/sh

interfaces=$(ip -o link show | awk -F': ' '{print $2}')

wifi_interface=$(ip -o link show | awk -F': ' '{print $2}' | grep "wl")
ethernet_interface=$(ip -o link show | awk -F': ' '{print $2}' | grep -E "^en|^eth")

ip_address_wifi=$(ip addr show $wifi_interface | awk '/inet / {print $2}' | cut -d'/' -f1)
ip_address_ethernet=$(ip addr show $ethernet_interface | awk '/inet / {print $2}' | cut -d'/' -f1)

if [ -n "$ip_address_wifi" ]; then
    icon="%{F#70A5EB}󰤢"
    ip_address=$ip_address_wifi
fi

if [ -n "$ip_address_ethernet" ]; then
    icon="%{F#70A5EB}󰈀"
    ip_address=$ip_address_ethernet
fi

if [ -z "$ip_address_ethernet" ] && [ -z "$ip_address_wifi" ]; then
    ip_address="Disconnected"
    icon="%{F#70A5EB}󱘖"
fi

echo "$icon %{F#DEE1E6}$ip_address"
