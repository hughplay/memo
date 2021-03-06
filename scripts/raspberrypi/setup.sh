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
