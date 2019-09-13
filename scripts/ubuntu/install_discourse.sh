# https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md

# Domain name
# namecheap: education.github.com/pack

# change timezone to UTC
sudo timedatectl set-timezone UTC

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
