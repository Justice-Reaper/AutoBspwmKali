#!/bin/bash

IP_ETH0=$(/usr/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}' | tr -d '\n')

if [ -n "$IP_ETH0" ]; then
    echo -n "$IP_ETH0" | xclip -sel clip
fi

IP_WLAN0=$(/usr/sbin/ifconfig wlan0 | grep "inet " | awk '{print $2}' | tr -d '\n')

if [ -n "$IP_WLAN0" ]; then
    echo -n "$IP_WLAN0" | xclip -sel clip
fi
