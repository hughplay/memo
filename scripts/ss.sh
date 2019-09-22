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


# V2Ray
# https://github.com/233boy/v2ray/wiki/V2Ray%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85%E8%84%9A%E6%9C%AC
bash <(curl -s -L https://git.io/v2ray.sh)

# client: https://www.v2ray.com/awesome/tools.html
# Mac OS X: https://github.com/Cenmrev/V2RayX
