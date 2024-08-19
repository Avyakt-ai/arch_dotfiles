#!/bin/bash

# Set the battery threshold
LOW_BATTERY_THRESHOLD=20

# Get the battery percentage
BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Check if the battery level is below the threshold
if [ "$BATTERY_LEVEL" -le "$LOW_BATTERY_THRESHOLD" ]; then
    # Send a notification
    dunstify -u critical "Battery Low" "Battery level is ${BATTERY_LEVEL}%!"
fi

