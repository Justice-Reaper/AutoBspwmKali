#!/bin/bash

ip_address=$(cat /home/user_replace/.config/bin/target | awk '{print $1}')

if [ $ip_address ]; then
    echo "%{F#E05F65}󰓾 %{F#DEE1E6}$ip_address%{u-}"

else
    echo "%{F#E05F65}󰓾 %{u-}%{F#DEE1E6}No target"
fi
