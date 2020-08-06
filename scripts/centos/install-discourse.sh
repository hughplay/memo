# Install Docker
# https://mirrors.tuna.tsinghua.edu.cn/help/docker-ce/

# modify repo mirror (optional)
# https://lug.ustc.edu.cn/wiki/mirrors/help/docker
sudo systemctl start docker

# Install Discourse
sudo -s
git clone https://github.com/discourse/discourse_docker.git /var/discourse
cd /var/discourse
# edit app.yml
./launcher rebuild app
