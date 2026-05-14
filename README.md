# Hot-Plug Btrbk Automation

This system automatically triggers a `btrbk` backup whenever a specific external hard drive is plugged in. It also provides desktop notifications so you know when it is safe to unplug the drive.

## Features
- **Automatic Trigger**: Uses `udev` to detect the drive via UUID.
- **Visual Feedback**: Desktop notifications for start, success, and failure.
- **Configuration-Driven**: Keeps your personal data in a separate config file.

## Setup

1. **Create Configuration**:
   ```bash
   sudo mkdir -p /etc/linuxscripts/
   sudo cp backup.conf.example /etc/linuxscripts/backup.conf
   ```
   Edit `/etc/linuxscripts/backup.conf` with your specific values (UUID, username, etc.).

2. **Run Installation**:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## Files
- `backup.conf.example`: Template for your private configuration.
- `install.sh`: Automatically applies your config to the system files.
- `99-btrbk-trigger.rules`: Udev rule (auto-populated by install script).
- `backup-notify.sh`: Main script with notification logic.
- `btrbk-backup.service`: Systemd service (auto-populated by install script).
