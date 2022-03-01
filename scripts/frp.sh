# https://github.com/fatedier/frp/blob/master/README_zh.md
# https://github.com/fatedier/frp/releases

# systemd - client (CentOS 7)
sudo cp frpc /usr/bin/
sudo mkdir /etc/frp
sudo cp frpc.ini /etc/frp
sudo cp systemd/frpc.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable frpc
sudo systemctl start frpc
sudo systemctl status frpc

# systemd - server (aliyun - Ubuntu)
cp frps /usr/bin/
mkdir /etc/frp
cp frps.ini /etc/frp
cp systemd/frps.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frps
systemctl start frps
systemctl status frps

# frpc.ini
[common]
server_addr = xxx.xxx.xxx.xxx
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 8888

[web]
type = http
local_ip = 127.0.0.1
local_port = 8080
custom_domains = http://xxx
