# https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md
# https://meta.discourse.org/t/replace-rubygems-org-with-taobao-mirror-to-resolve-network-error-in-china/21988
# (optional) edit templates/web.china.template.yml - https://mirrors.tuna.tsinghua.edu.cn/help/rubygems/
# in app.yml
templates:
  - "templates/web.china.yml"

# Domain name
# namecheap: education.github.com/pack

# Change timezone to UTC
sudo timedatectl set-timezone UTC
sudo service cron restart

# Git - /etc/ssh/ssh_config
GSSAPIAuthentication no

# Docker
# Best in aliyun: https://cr.console.aliyun.com/cn-beijing/instances/mirrors
# http://mirrors.ustc.edu.cn/help/docker-ce.html
# download.docker.com -> mirrors.ustc.edu.cn/docker-ce
# mirror: http://mirrors.ustc.edu.cn/help/dockerhub.html#id3

# Email Server
# Mailjet: https://www.mailjet.com/
# My account -> Senders & Domains (do 3 part one by one)
# !Important: If you own `example.com`, please 
# (Maybe 网易企业邮箱: http://ym.163.com)

# Install plugin
# https://meta.discourse.org/t/install-plugins-in-discourse/19157
# - git clone https://github.com/discourse/discourse-math.git     
# - git clone https://github.com/discourse/discourse-solved.git   
# - git clone https://github.com/discourse/discourse-checklist.git

# Create admin
./launcher enter app
rake admin:create

crontab -e
0 0,12 * * * /var/discourse/shared/standalone/scripts/update_score.py

## disable read-only mode
./launcher enter app
rails c
Discourse.disable_readonly_mode(Discourse::USER_READONLY_MODE_KEY)

## change domain name
# 1. edit containers/app.yml
./launcher rebuild app
./launcher enter app
discourse remap <old domain> <new domain>
rake posts:rebake

## Restore backup
# https://meta.discourse.org/t/restore-a-backup-from-command-line/108034
./launcher enter app
discourse enable_restore
discourse restore <name>.tar.gz

## Enable hostname in local network
# https://www.anastis.gr/setting-hostname-avahi-mdns/
#hostnamectl set-hostname <new name>
#yum install -y avahi
# apt-get install avahi-daemon
#systemctl enable avahi
#systemctl start avahi
