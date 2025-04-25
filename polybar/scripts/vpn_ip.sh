#!/bin/bash

interface=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')

if [ "$interface" = "tun0" ]; then
    echo "%{F#76B97F}󰞀 %{F#DEE1E6}$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')"
else
    echo "%{F#76B97F}󰞀 %{F#DEE1E6}Disconnected"
fi
