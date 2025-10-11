#!/bin/bash

/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}' | tr -d '\n' | xclip -sel clip
