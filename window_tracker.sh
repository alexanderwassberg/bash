#!/bin/bash

# Fil för utdata där fönsteraktivitet sparas
output_file="window_activity.txt"

# Initialisera variabler för att spåra det aktiva fönstret och starttid
active_window=""
start_time=""

while true; do
    # Hämta ID för det aktiva fönstret
    current_window=$(xdotool getactivewindow)

    # Kontrollera om det aktiva fönstret har ändrats
    if [ "$current_window" != "$active_window" ]; then
        # Beräkna tiden som spenderats i det föregående fönstret
        if [ -n "$active_window" ] && [ -n "$start_time" ]; then
            end_time=$(date +%s)
            elapsed_time=$((end_time - start_time))

            # Hämta fönsternamnet
            window_name=$(xdotool getwindowname "$active_window")

            # Lägg till aktiviteten i utdatafilen
            echo "$(date "+%Y-%m-%d %H:%M:%S") - Fönster: $window_name - Tid: $elapsed_time sekunder" >> "$output_file"
        fi

        # Uppdatera det aktiva fönstret och starttiden
        active_window="$current_window"
        start_time=$(date +%s)
    fi

    # Vänta en kort stund (t.ex. 1 sekund) innan nästa kontroll
    sleep 1
done
