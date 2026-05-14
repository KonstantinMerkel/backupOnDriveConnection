# Hot-Plug Btrbk Automation

This system automatically triggers a `btrbk` backup whenever a specific external hard drive is plugged in. It also provides desktop notifications so you know when it is safe to unplug the drive.

## Features
- **Automatic Trigger**: Uses `udev` to detect the drive via UUID.
- **Visual Feedback**: Desktop notifications for start, success, and failure.
- **Safety**: Wait logic ensures the drive is fully mounted before starting.

## Prerequisites
- `btrbk` installed and configured.
- `libnotify` (for `notify-send`).

## Setup

1. **Find your Drive UUID**:
   Plug in your drive and run:
   ```bash
   lsblk -dno UUID /dev/sdXY  # Replace sdXY with your drive partition
   ```

2. **Configure the scripts**:
   - Update `99-btrbk-trigger.rules` with your drive's UUID.
   - Update `backup-notify.sh` with your local username.
   - Update `btrbk-backup.service` with your drive's mount path.

3. **Install**:
   ```bash
   sudo cp 99-btrbk-trigger.rules /etc/udev/rules.d/
   sudo cp btrbk-backup.service /etc/systemd/system/
   sudo cp backup-notify.sh /usr/local/bin/
   sudo chmod +x /usr/local/bin/backup-notify.sh
   ```

4. **Reload**:
   ```bash
   sudo udevadm control --reload-rules
   sudo systemctl daemon-reload
   ```
