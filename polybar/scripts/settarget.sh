#!/bin/bash

ip_address=$(cat ~/.config/bin/target | awk '{print $1}')
machine_name=$(cat ~/.config/bin/target | awk '{print $2}')

if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#E05F65}󰓾 %{F#DEE1E6}$ip_address%{u-} - $machine_name"
else
    if [ $ip_address ]; then
	echo "%{F#E05F65}󰓾 %{F#DEE1E6}$ip_address%{u-}"
    else
        echo "%{F#E05F65}󰓾 %{u-}%{F#DEE1E6}No target"
    fi
fi
