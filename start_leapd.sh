#!/bin/sh

#if ping -q -c 1 -W 1 google.com >/dev/null 2>&1; then
#  echo "The network is up" > /home/lamp/meschup-client-rpi/startup.log
#else
#  echo "The network is down"
  #exit 1
#fi

echo "lamp." | sudo -S service leapd start >/dev/null

cd /home/lamp/meschup-client-rpi 

nohup node index.js >/home/lamp/meschup-client-rpi/startup.log




