# Basic shadowsocks seems very slow
# https://shadowsocks.be/9.html

wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
chmod +x shadowsocksR.sh
./shadowsocksR.sh 2>&1 | tee shadowsocksR.log

# rc4-md5
# auth_sha1_v4
# tls1.2_ticket_auth

# Windows: https://github.com/shadowsocksrr/shadowsocksr-csharp/releases
# OS X: https://github.com/shadowsocks/shadowsocks-iOS/wiki/Shadowsocks-for-OSX-Help
