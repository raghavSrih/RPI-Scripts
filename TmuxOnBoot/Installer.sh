#!/bin/sh

Pr_dir=`pwd`
usr=`whoami`

#change the user and working directory and then Copy TmuxOnBoot.service to /etc/systemd/system/

sed -i "s/User=.*/User=$usr/" TmuxOnBoot.service
sed -i "s|WorkingDirectory=.*|WorkingDirectory=$Pr_dir|" TmuxOnBoot.service
sed -i "s|ExecStart=.*|ExecStart=/bin/sh $Pr_dir/start_tmux.sh|" TmuxOnBoot.service

sudo cp TmuxOnBoot.service /etc/systemd/system/TmuxOnBoot.service

# Then reload the systemd deamon
sudo systemctl daemon-reload

# Test the service by starting it using systemctl
sudo systemctl start TmuxOnBoot.service

sudo systemctl stop TmuxOnBoot.service

# Enable the service
sudo systemctl enable TmuxOnBoot.service

# Reboot the system
echo "Please restart the system."


