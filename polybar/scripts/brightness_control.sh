#!/bin/bash

# Script para mostrar el nivel de brillo en Polybar

# Configuración de colores y símbolos
LABEL="%{F#E784A7}󰃠%{F-}"
BAR_WIDTH=10
BAR_FILL="━"
BAR_EMPTY="━"
COLOR_FILL="#E784A7"
COLOR_EMPTY="#DEE1E6"

# Obtener nivel de brillo actual (reemplazar por el comando adecuado para tu sistema)
BRIGHTNESS=$(cat /sys/class/backlight/*/brightness)
MAX_BRIGHTNESS=$(cat /sys/class/backlight/*/max_brightness)

# Calcular el porcentaje de brillo
PERCENT=$(( BRIGHTNESS * 100 / MAX_BRIGHTNESS ))

# Generar la barra de brillo
FILLED=$(( BAR_WIDTH * PERCENT / 100 ))
EMPTY=$(( BAR_WIDTH - FILLED ))
BAR=""
for ((i = 0; i < FILLED; i++)); do
  BAR+="%{F$COLOR_FILL}$BAR_FILL%{F-}"
done
for ((i = 0; i < EMPTY; i++)); do
  BAR+="%{F$COLOR_EMPTY}$BAR_EMPTY%{F-}"
done

# Mostrar el resultado
echo -e "$LABEL $BAR"
