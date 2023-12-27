#!/bin/bash

cat /home/user_replace/.config/bin/target | awk '{print $1}' | tr -d '\n' | xclip -sel clip
