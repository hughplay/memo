# Public DNS
# Local DNS: http://tools.cloudxns.net/Index/Diag
# Foreign DNS: https://www.opennic.org/
# 114    - 114.114.114.114
# AliDNS - 223.5.5.5
# Baidu  - 180.76.76.76
# Tecent - 119.29.29.29 √


# TUNA openwrt
sed -i 's/downloads.openwrt.org/mirrors.tuna.tsinghua.edu.cn\/lede/g' /etc/opkg/distfeeds.conf


# IPV6 - https://github.com/tuna/ipv6.tsinghua.edu.cn/blob/master/openwrt.md
opkg update && opkg install ip6tables kmod-ipt-nat6 kmod-ip6tables kmod-ip6tables-extra luci-proto-ipv6 iputils-traceroute6
# IPv6 ULA-Prefix fd0a:f047:3583::/64
# Network -> Interfaces -> LAN -> DHCP Server -> check `Always announce default router`

# /etc/firewall.user
WAN6=eth0.2
LAN=br-lan
ip6tables -t nat -A POSTROUTING -o $WAN6 -j MASQUERADE
ip6tables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -A FORWARD -i $LAN -j ACCEPT

# /etc/hotplug.d/iface/99-ipv6
#!/bin/sh
[ "$ACTION" = ifup ] || exit 0
iface=wan6
[ -z "$iface" -o "$INTERFACE" = "$iface" ] || exit 0
ip -6 route add `ip -6 route show default|sed -e 's/from [^ ]* //'`
logger -t IPv6 "Add IPv6 default route."

chmod +x /etc/hotplug.d/iface/99-ipv6

# Shadowsocks - https://alalin.me/archives/805
crontab -e
# m h  dom mon dow   command
# <minute> <hour> <day of month> <month> <day of week> <command>
# 0 5 5 * *    wget --no-check-certificate https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt -O /tmp/china_ip_list.txt && mv /tmp/china_ip_list.txt /etc/chinadns_chnroute.txt
/etc/init.d/cron start
/etc/init.d/cron enable
