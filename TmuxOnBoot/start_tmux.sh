#!/bin/bash

Pr_dir=`pwd`
usr=`whoami`

logfile=$Pr_dir'/tmuxstart.log'

> $logfile

#echo "lamp." | sudo -S service leapd start >> /home/pi/RPI-Scripts-master/startleapd.log 2>&1

#cd /home/lamp/meschup-client-rpi >> /home/pi/RPI-Scripts-master/startleapd.log 2>&1

/usr/bin/tmux new-session -d -s sess1 >> $logfile 2>&1

/usr/bin/tmux set-option -t sess1 set-remain-on-exit on

/usr/bin/tmux new-window -d -n 'trial' -t sess1:1 "sudo ${Pr_dir}/trial.sh >> $logfile"

#/usr/bin/tmux a -t sess1 "sudo ${Pr_dir}/trial.sh >> $logfile"

#tmux kill-session -t sessionname

#nohup node index.js >/home/lamp/meschup-client-rpi/startup.log >> /home/pi/RPI-Scripts-master/startleapd.log 2>&1




