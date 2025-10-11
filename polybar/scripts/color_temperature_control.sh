#!/bin/bash

color_temperature_kelvin_file=/home/user_replace/.config/bin/color_temperature_kelvin
color_temperature_kelvin=$(cat $color_temperature_kelvin_file)

color_temperature_percentage_file=/home/user_replace/.config/bin/color_temperature_percentage
color_temperature_percentage=$(cat $color_temperature_percentage_file)

redshift_status_file=/home/user_replace/.config/bin/redshift_status
redshift_status=$(cat $redshift_status_file)

calculate_percentage() {
    local percentage=$1
    local base=$2
    local max=$3

    local range=$((max - base))

    local result=$((base + (range * percentage) / 100))

    echo "$result"
}

update_color_temperature(){
    if [ $1 -ge 1000 ] && [ $1 -le 6500 ]; then
        redshift -P -O $1 &> /dev/null
        echo $1 > $color_temperature_kelvin_file
        echo $2 > $color_temperature_percentage_file
    fi
}

case $1 in
  toggle)
    if [ "$redshift_status" = "On" ]; then
      echo 'Off' > "$redshift_status_file"
      redshift -x &> /dev/null
    else
      echo 'On' > "$redshift_status_file"
      update_color_temperature $color_temperature_kelvin $color_temperature_percentage
    fi
    ;;
  increase)
    if [ "$redshift_status" = "On" ]; then
        percentage=$((color_temperature_percentage + 5))
        kelvin=$(calculate_percentage $percentage 1000 6500)
        update_color_temperature $kelvin $percentage
    fi
    ;;
  decrease)
    if [ "$redshift_status" = "On" ]; then
        percentage=$((color_temperature_percentage - 5))
        kelvin=$(calculate_percentage $percentage 1000 6500)
        update_color_temperature $kelvin $percentage
    fi
    ;;
  temperature)
    if [ "$redshift_status" = "On" ]; then
      redshift -P -O $color_temperature_kelvin &> /dev/null
      echo "  %{F#F1CF8A} %{F#DEE1E6}$color_temperature_percentage%"
    elif [ "$redshift_status" = "Off" ]; then
      echo "  %{F#F1CF8A} %{F#DEE1E6}Off"
    fi
    ;;
esac
