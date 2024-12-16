#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/1000"
export PULSE_SERVER="unix:/run/user/1000/pulse/native"

/usr/bin/paplay /home/justice-reaper/.config/sound/wavs/remove-usb.wav &
