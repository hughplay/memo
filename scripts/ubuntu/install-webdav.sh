# https://www.techrepublic.com/article/how-to-enable-webdav-on-your-ubuntu-server/
sudo apt-get install apache2
apt-get update
sudo a2enmod dav
sudo systemctl restart apache2
# optional change port
sudo vim /etc/apache2/ports.conf
sudo vim /etc/apache2/sites-enabled/000-default.conf
systemctl restart apache2
#
sudo a2enmod dav_f
sudo a2enmod dav_fs
sudo systemctl restart apache2
sudo mkdir -p /var/www/webdav
sudo chown www-data /var/www/webdav
sudo vim /etc/apache2/sites-available/webdav.conf
sudo a2ensite webdav.conf
sudo adduser xxx
sudo htpasswd -c /var/www/webdav/passwd.dav xxx
sudo chown root:www-data /var/www/webdav/passwd.dav
sudo chmod 640 /var/www/webdav/passwd.dav
sudo systemctl restart apache2
