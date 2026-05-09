#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/1000"
export PULSE_SERVER="unix:/run/user/1000/pulse/native"

/usr/bin/paplay /home/user_replace/.config/sound/wavs/add-usb.wav &
