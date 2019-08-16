# Install Docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

# modify repo mirror
# https://lug.ustc.edu.cn/wiki/mirrors/help/docker
sudo systemctl start docker

# docker --version
# Docker version 19.03.1, build 74b1e89

# Install Discourse
sudo -s
git clone https://github.com/discourse/discourse_docker.git /var/discourse
cd /var/discourse

# https://meta.discoursecn.org/t/topic/2659/2
# mlbrain.com
# mx.ym.163.com
