#!/bin/bash

{
find /usr/share/applications -name "*.desktop"
find /home/justice-reaper/.local/share/applications -name "*.desktop" 2>/dev/null
} | while read -r file; do
    if grep -qi "terminal=false" "$file"; then
        # Ignorar archivos que contengan exec-in-shell
        if grep -qi "exec-in-shell" "$file"; then
            continue
        fi
        
        if grep -q "^Exec=" "$file"; then
            exec_line=$(grep "^Exec=" "$file" | head -1)
            original_command=$(echo "$exec_line" | sed 's/^Exec=//')

            new_command=""
            changed=false

            while read -r word; do
                if [ -n "$word" ]; then
                    if [[ "$word" != /* ]] && [[ "$word" != *%* ]]; then
                        absolute_path=$(which "$word" 2>/dev/null)
                        if [ $? -eq 0 ] && [ -n "$absolute_path" ]; then
                            new_command="$new_command $absolute_path"
                            changed=true
                        else
                            new_command="$new_command $word"
                        fi
                    else
                        new_command="$new_command $word"
                    fi
                fi
            done < <(echo "$original_command" | tr ' ' '\n')

            if [ "$changed" = true ]; then
                new_command=$(echo "$new_command" | sed 's/^ //')
                sed -i "s|^$exec_line|Exec=$new_command|" "$file"
            fi
        fi

        if grep -qi "^Categories=" "$file"; then
            if ! grep -qi "Rofi;" "$file"; then
                sed -i '/^Categories=/s/$/Rofi;/' "$file"
            fi
        else
            echo "Categories=Rofi;" >> "$file"
        fi
    fi
done
