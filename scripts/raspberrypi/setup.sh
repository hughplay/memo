## Enable SSH
# https://howchoo.com/g/ote0ywmzywj/how-to-enable-ssh-on-raspbian-without-a-screen
touch /boot/ssh
## Connect to Wifi
# https://howchoo.com/g/ndy1zte2yjn/how-to-set-up-wifi-on-your-raspberry-pi-without-ethernet
# /boot/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
country=CN

network={
	ssid="<WIFI NAME>"
	psk="<WIFI PASSWORD>"
}
# if encounter wifi error in raspi-config (maybe you need modify wpa_supplicant.conf first)
sudo killall wpa_supplicant
sudo wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0

# ubuntu
# https://roboticsbackend.com/install-ubuntu-on-raspberry-pi-without-monitor/#Setup_Wi-Fi_and_ssh_for_your_Raspberry_Pi_4_without_a_monitor
# in router
arp -a
# setup
sudo adduser pi
sudo adduser pi sudo
sudo deluser ubuntu
sudo hostnamectl set-hostname playboard

# /etc/sudoers
ubuntu ALL=(ALL) NOPASSWD:ALL

# ubuntu 20.04 - wifi
sudo apt install NetworkManager
sudo vim /etc/01-netcfg.yaml
network:
    version: 2
	renderer: NetworkManager
	ethernets:
		eth0:
			dhcp4: true
			dhcp6: true
			optional: true
sudo netplan generaton
sudo netplan apply
