#!/bin/bash

cat /home/user_replace/.config/bin/target | tr -d '\n' | xclip -sel clip
