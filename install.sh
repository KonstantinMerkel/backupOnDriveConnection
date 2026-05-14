#!/bin/bash
# Simple installation script to "bake" the config into system files

CONF="/etc/linuxscripts/backup.conf"

if [ ! -f "$CONF" ]; then
    echo "Error: Configuration file $CONF not found."
    echo "Please create it first using backup.conf.example as a template."
    exit 1
fi

source "$CONF"

echo "Installing backup system..."

# 1. Install config folder
sudo mkdir -p /etc/linuxscripts/

# 2. Update and install udev rule (replaces placeholder with real UUID)
sed "s/YOUR_DRIVE_UUID_HERE/$DRIVE_UUID/" 99-btrbk-trigger.rules > 99-btrbk-trigger.rules.tmp
sudo cp 99-btrbk-trigger.rules.tmp /etc/udev/rules.d/99-btrbk-trigger.rules
rm 99-btrbk-trigger.rules.tmp

# 3. Install service and script
sudo cp btrbk-backup.service /etc/systemd/system/
sudo cp backup-notify.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/backup-notify.sh

# 4. Reload
sudo udevadm control --reload-rules
sudo systemctl daemon-reload

echo "Done! Backup system installed and configured for drive $DRIVE_UUID"
