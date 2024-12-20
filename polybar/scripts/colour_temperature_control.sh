#!/bin/bash

colour_temperature_kelvin_file=/home/user_replace/.config/bin/colour_temperature_kelvin
colour_temperature_kelvin=$(cat $colour_temperature_kelvin_file)

colour_temperature_percentage_file=/home/user_replace/.config/bin/colour_temperature_percentage
colour_temperature_percentage=$(cat $colour_temperature_percentage_file)

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

update_colour_temperature(){
    if [ $1 -ge 1000 ] && [ $1 -le 25000 ]; then
        redshift -P -O $1 &> /dev/null
        echo $1 > $colour_temperature_kelvin_file
        echo $2 > $colour_temperature_percentage_file
    fi
}

case $1 in
  toggle)
    if [ "$redshift_status" = "On" ]; then
      echo 'Off' > "$redshift_status_file"
      redshift -x &> /dev/null
    else
      echo 'On' > "$redshift_status_file"
      update_colour_temperature $colour_temperature_kelvin $colour_temperature_percentage
    fi
    ;;
  increase)
    if [ "$redshift_status" = "On" ]; then
        percentage=$((colour_temperature_percentage + 5))
        kelvin=$(calculate_percentage $percentage 1000 25000)
        update_colour_temperature $kelvin $percentage
    fi
    ;;
  decrease)
    if [ "$redshift_status" = "On" ]; then
        percentage=$((colour_temperature_percentage - 5))
        kelvin=$(calculate_percentage $percentage 1000 25000)
        update_colour_temperature $kelvin $percentage
    fi
    ;;
  temperature)
    if [ "$redshift_status" = "On" ]; then
      redshift -P -O $colour_temperature_kelvin &> /dev/null
      echo " $colour_temperature_percentage%"
    elif [ "$redshift_status" = "Off" ]; then
      echo " Off"
    fi
    ;;
esac
