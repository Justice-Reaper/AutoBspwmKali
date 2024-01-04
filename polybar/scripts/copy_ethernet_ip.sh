#!/bin/bash

IP_WIFI=$(/usr/sbin/ifconfig wifi_replace | grep "inet " | awk '{print $2}' | tr -d '\n')

if [ -n "$IP_WIFI" ]; then
    echo -n "$IP_WIFI" | xclip -sel clip
fi

IP_ETHERNET=$(/usr/sbin/ifconfig ethernet_replace | grep "inet " | awk '{print $2}' | tr -d '\n')

if [ -n "$IP_ETHERNET" ]; then
    echo -n "$IP_ETHERNET" | xclip -sel clip
fi
