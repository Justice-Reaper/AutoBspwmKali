#!/bin/bash

{
find /usr/share/applications -name "*.desktop"
find /home/user_replace/.local/share/applications -name "*.desktop" 2>/dev/null
} | while read -r file; do
    if ( grep -qi "terminal=false" "$file" ) || ( ! grep -qi "terminal=" "$file" && grep -qi "type=application" "$file" ); then
        if grep -qi "exec-in-shell" "$file"; then
            continue
        fi

        if grep -qi "x-www-browser" "$file"; then
            continue
        fi

        if grep -qi "^Name=.*\(picom\|terminal\|rofi\|flameshot\)" "$file"; then
            continue
        fi

        if grep -qi "^Exec=.*pkexec" "$file"; then
            if ! grep -qi "^Exec=sh -c \".*pkexec" "$file"; then
                sed -i 's/^Exec=\(.*pkexec.*\)/Exec=sh -c "\1"/' "$file"
            fi
        fi

        if grep -qi "^Categories=" "$file"; then
            if ! grep -qi "Rofi;" "$file"; then
                sed -i 's/^Categories=/&Rofi;/' "$file"
            fi
        else
            echo "Categories=Rofi;" >> "$file"
        fi
    fi
done
