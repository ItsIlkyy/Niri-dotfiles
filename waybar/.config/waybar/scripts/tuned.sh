#!/usr/bin/env bash

# Define the profiles you want to cycle through
PROFILES=("powersave" "balanced" "throughput-performance")

# Get current active profile
CURRENT=$(tuned-adm active | awk -F': ' '{print $2}')

# Handle click action to cycle profiles
if [ "$1" == "toggle" ]; then
    NEXT_INDEX=0
    for i in "${!PROFILES[@]}"; do
        if [[ "${PROFILES[$i]}" == "$CURRENT" ]]; then
            NEXT_INDEX=$(( (i + 1) % ${#PROFILES[@]} ))
            break
        fi
    done
    tuned-adm profile "${PROFILES[$NEXT_INDEX]}"
    CURRENT="${PROFILES[$NEXT_INDEX]}"
fi

# Assign icons and CSS classes based on the profile
case "$CURRENT" in
    *powersave*)
        ICON="   "
        CLASS="powersave"
        ;;
    *balanced*)
        ICON=" 󰗑  "
        CLASS="balanced"
        ;;
    *performance*|*latency*)
        ICON=" 󰓅  "
        CLASS="performance"
        ;;
    *)
        ICON="  "
        CLASS="default"
        ;;
esac

# Output JSON for Waybar
echo "{\"text\": \"$ICON\", \"tooltip\": \"TuneD Profile: $CURRENT\", \"class\": \"$CLASS\"}"
