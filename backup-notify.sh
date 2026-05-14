#!/bin/bash
# Description: Triggers btrbk and sends desktop notifications

# Configuration
TARGET_USER="YOUR_USERNAME_HERE"
USER_ID=$(id -u $TARGET_USER)

# Function to send notification as the user
notify() {
    local urgency=$1
    local title=$2
    local body=$3
    # Connect to the user's DBus session to show the popup
    sudo -u $TARGET_USER DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus \
    notify-send -u $urgency -i drive-harddisk "$title" "$body"
}

# Notify Start
notify "normal" "Backup Started" "Drive detected. Please wait..."

# Run btrbk (capture exit code)
/usr/bin/btrbk run
EXIT_CODE=$?

# Notify Result
if [ $EXIT_CODE -eq 0 ]; then
    notify "normal" "Backup Complete" "Success! You may unplug the drive."
else
    notify "critical" "Backup Failed" "Error code: $EXIT_CODE. Check logs."
fi

exit $EXIT_CODE
