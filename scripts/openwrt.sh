# TUNA openwrt
sed -i 's/downloads.openwrt.org/mirrors.tuna.tsinghua.edu.cn\/lede/g' /etc/opkg/distfeeds.conf
opkg update

# IPV6 - https://windard.com/blog/2018/06/18/Openwrt-Ipv6
opkg install kmod-ipt-nat6
ip6tables -t nat -I POSTROUTING -s `uci get network.globals.ula_prefix` -j MASQUERADE
route -A inet6 add 2000::/3 `route -A inet6 | grep ::/0 | awk 'NR==1{print "gw "$2" dev "$7}'`

# Shadowsocks - https://alalin.me/archives/805
crontab -e
# <minute> <hour> <day of month> <month> <day of week> <command>
# 0 5 5 * *    wget --no-check-certificate https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt -O /tmp/china_ip_list.txt && mv /tmp/china_ip_list.txt /etc/chinadns_chnroute.txt
/etc/init.d/cron start
/etc/init.d/cron enable
