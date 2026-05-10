#!/bin/bash

FILE="/home/user_replace/.config/bin/scope"
ASSETS=$(grep '[^[:space:]]' "$FILE" 2>/dev/null | wc -l)

if [[ "$ASSETS" -eq 0 ]]; then
    echo "  %{T3}%{F#E05F65}󰞇 %{T-}%{F#DEE1E6}No Scope"
else
    echo "  %{T3}%{F#E05F65}󰞇 %{T-}%{F#DEE1E6}Scope ($ASSETS)"
fi
