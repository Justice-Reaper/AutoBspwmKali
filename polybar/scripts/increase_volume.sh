#!/bin/bash

VOLUME=$(pactl list sinks | grep 'Volume:' | awk '{print $5; exit}' | sed 's/%//')

if [ "$VOLUME" -lt "100" ]; then
    pactl -- set-sink-volume 0 +10%
fi

