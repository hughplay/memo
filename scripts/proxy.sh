# CentOS service use proxy
# https://www.thegeekdiary.com/how-to-configure-docker-to-use-proxy/

mkdir /etc/systemd/system/docker.service.d
vim /etc/systemd/system/docker.service.d/http-proxy.conf

[Service]
Environment="HTTP_PROXY=http://user01:password@10.10.10.10:8080/"
Environment="HTTPS_PROXY=https://user01:password@10.10.10.10:8080/"
Environment="NO_PROXY= hostname.example.com,172.10.10.10"

systemctl daemon-reload
systemctl show docker --property Environment
systemctl restart docker

# ---
# Configure Docker to use a proxy server
vim ~/.docker/config.json

{
 "proxies":
 {
   "default":
   {
     "httpProxy": "http://127.0.0.1:3001",
     "httpsProxy": "http://127.0.0.1:3001",
     "noProxy": "*.test.example.com,.example2.com"
   }
 }
}


## Squid
yum install -y squid
cp /etc/squid/squid.conf.default /etc/squid/squid.conf
vim /etc/squid/squild.conf
#http_access deny CONNECT !SSL_ports
systemctl enable squid
systemctl start squid
firewall-cmd --zone=public --permanent --add-port=3128/tcp
firewall-cmd --reload

# ~/.bashrc
alias nic='export http_proxy="http://xxx:3128" https_proxy="http://xxx:3128"'
nic
