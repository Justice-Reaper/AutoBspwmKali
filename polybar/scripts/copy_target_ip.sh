#!/bin/bash

cat ~/.config/bin/target | awk '{print $1}' | tr -d '\n' | xclip -sel clip
