# Install Ubuntu Remotely

# Scenario
#   We want to replace the system of a remote server from CentOS to Ubuntu.
#   However, we can not access the remote server physically.

# Steps

# 1. Install debootstrap from epel-release
sudo yum install -y epel-release
sudo yum install -y debootstrap

# 2. 
# /dev/sda ? /dev/sda1 ?
#   https://www.debian.org/releases/buster/amd64/apcs04.en.html
#   https://serverfault.com/questions/338937/differences-between-dev-sda-and-dev-sda1
#   https://superuser.com/questions/558156/what-does-dev-sda-for-linux-mean
