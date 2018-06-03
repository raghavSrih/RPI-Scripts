#!/bin/sh

# Copy start_leapd.service to /etc/systemd/system/
sudo cp TmuxOnBoot.service /etc/systemd/system/TmuxOnBoot.service

# Then reload the systemd deamon
sudo systemctl deamon-reload

# Test the service by starting it using systemctl
sudo systemctl start TmuxOnBoot.service

sudo systemctl stop TmuxOnBoot.service

# Enable the service
sudo systemctl enable TmuxOnBoot.service

# Reboot the system
echo "Please restart the system."


