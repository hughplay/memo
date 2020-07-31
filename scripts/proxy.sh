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
