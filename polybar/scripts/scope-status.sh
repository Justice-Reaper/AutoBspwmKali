#!/bin/bash

file="/home/user_replace/.config/bin/scope"
assets=$(grep '[^[:space:]]' "$file" 2>/dev/null | wc -l)

if [[ "$assets" -eq 0 ]]; then
    echo "  %{T3}%{F#E05F65}󰞇 %{T-}%{F#DEE1E6}No Scope"
else
    echo "  %{T3}%{F#E05F65}󰞇 %{T-}%{F#DEE1E6}Scope ($assets)"
fi
