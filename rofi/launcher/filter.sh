#!/bin/bash

{
find /usr/share/applications -name "*.desktop"
find /home/user_replace/.local/share/applications -name "*.desktop" 2>/dev/null
} | while read -r file; do
    if grep -qi "terminal=false" "$file"; then
        if grep -qi "^Categories=" "$file"; then
            if ! grep -qi "Rofi;" "$file"; then
                sed -i '/^Categories=/s/$/Rofi;/' "$file"
            fi
        else
            echo "Categories=Rofi;" >> "$file"
        fi
    fi
done
