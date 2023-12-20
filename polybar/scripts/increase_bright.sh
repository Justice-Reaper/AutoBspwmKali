#!/bin/bash

brillo_maximo=$(brightnessctl -q m)

brillo_actual=$(cat /sys/class/backlight/amdgpu_bl0/brightness)

porcentaje_brillo=$((brillo_actual * 100 / brillo_maximo))

nuevo_brillo=$((porcentaje_brillo + 10))

brightnessctl -q s "$nuevo_brillo%"

cat /sys/class/backlight/amdgpu_bl0/actual_brightness
