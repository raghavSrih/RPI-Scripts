#!/bin/sh

# exit 1 --> for unsuccessful installation of hostapd package
# exit 2 --> for unsuccessful installation of dnsmasq package

dt=`date +%d_%m_%Y`  #This is used to show the date of installation and backups of file

logfile=Installations$dt.log

echo $dt

sudo apt-get install hostapd
if [ `echo $?` -eq 0 ]
then
	echo "Installation of hostapd package is successful"
else
	echo "Could not install hostapd package.. Exiting. Please check the logfile $logfile"
	exit 1
fi

sudo apt-get install dnsmasq
if [ `echo $?` -eq 0 ]
then
        echo "Installation of hostapd package is successful"
else
        echo "Could not install hostapd package.. Exiting. Please check the logfile $logfile"
        exit 1
fi

# Configuring dhcp 

sudo cp /etc/dhcpcd.conf /etc/dhcpcd.conf_bkp_$dt 
echo "denyinterfaces wlan0" | sudo tee -a /etc/dhcpcd.conf >$logfile 

# Configuring network-interfaces

sudo cp /etc/network/interfaces /etc/network/interfaces_bkp_$dt
sudo sed -i '/auto lo/r ./config/net_interface' /etc/network/interfaces
sudo sed -i '/^\s*wpa/s/^/#/' /etc/network/interfaces

# Restarting dhdcpcd and wlan0

sudo service dhcpcd restart
sudo ifdown wlan0; sudo ifup wlan0

# Configuring HostAPD

if [ -f /etc/hostapd/hostapd.conf ]
then
	sudo mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf_bkp_$dt
fi

cat ./config/hostapd_conf | sudo tee -a /etc/hostapd/hostapd.conf >>$logfile

sudo cp /etc/default/hostapd /etc/default/hostapd_bkp_$dt
sudo sed -i 's/\s*DAEMON_CONF=.*/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd

sudo cp /etc/init.d/hostapd /etc/init.d/hostapd_bkp_$dt
sudo sed -i 's/\s*DAEMON_CONF=.*/DAEMON_CONF=\/etc\/hostapd\/hostapd.conf/' /etc/init.d/hostapd

# Configuring Dnsmasq

sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf_bkp_$dt
sudo cp ./config/dnsmasq_conf /etc/dnsmasq.conf

#IPV4 Configuration

sudo cp /etc/sysctl.conf /etc/sysctl.conf_bkp_$dt
sudo sed -i 's/\s*#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"   #To restart the service

#Updating iptables  for Network Address Translation between eth0 and wlan0

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT


#Updating /etc/rc.local file to restore the iptables which were changed above 

sudo cp /etc/rc.local /etc/rc.local_bkp_$dt
sudo sed -i '/^exit 0/i iptables-restore <\/etc\/iptables.ipv4.nat' /etc/rc.local

#Starting Hostapd and Dnsmasq

echo "Installation is successful"
echo "Please restart the system"



