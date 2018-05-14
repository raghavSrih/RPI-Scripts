date > /home/lamp/restart_service.log

status=`echo "lamp." | sudo -S service leapd status | awk '{ if(NR==3) { print $2 } }'`

if [ "$status" = "active" ]
then
	echo " Service is running" >>/home/lamp/restart_service.log
else
	echo " Service is not running" >>/home/lamp/restart_service.log
	echo " Restarting the service" >>/home/lamp/restart_service.log
	echo "lamp." | sudo -S service leapd start >>/home/lamp/restart_service.log
	ps -ef | grep -v grep | grep "/usr/sbin/leapd" >>/home/lamp/restart_service.log
fi

