#!/bin/bash

logfile='/home/pi/RPI-Scripts-master/TmuxOnBoot/tmuxstart.log'

> $logfile

#echo "lamp." | sudo -S service leapd start >> /home/pi/RPI-Scripts-master/startleapd.log 2>&1

#cd /home/lamp/meschup-client-rpi >> /home/pi/RPI-Scripts-master/startleapd.log 2>&1

/usr/bin/tmux new-session -d -s sess1 >> $logfile 2>&1

/usr/bin/tmux set-option -t sess1 set-remain-on-exit on

/usr/bin/tmux new-window -d -n 'trial' -t sess1:1 'sudo /home/pi/RPI-Scripts-master/TmuxOnBoot/trial.sh >> /home/pi/RPI-Scripts-master/TmuxOnBoot/tmuxstart.log'

#tmux kill-session -t sessionname

#nohup node index.js >/home/lamp/meschup-client-rpi/startup.log >> /home/pi/RPI-Scripts-master/startleapd.log 2>&1




