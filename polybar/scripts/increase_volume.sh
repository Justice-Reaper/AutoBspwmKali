#!/bin/bash

volume=$(pactl list sinks | grep 'Volume:' | awk '{print $5; exit}' | sed 's/%//')

if [ "$volume" -lt "100" ]; then
    pactl -- set-sink-volume 0 +10%
fi

