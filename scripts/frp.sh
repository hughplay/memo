# https://github.com/fatedier/frp/blob/master/README_zh.md

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
