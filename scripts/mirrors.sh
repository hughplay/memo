## pypi
# https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

## conda
# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
# Miniconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/
vim ~/.condarc

channels:
  - defaults
show_channel_urls: true
channel_alias: https://mirrors.tuna.tsinghua.edu.cn/anaconda
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  
## ubuntu
# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/

## centos
# https://mirrors.tuna.tsinghua.edu.cn/help/centos/
  
## raspberry pi
# `/etc/apt/sources.list`
deb http://mirrors.tuna.tsinghua.edu.cn/raspberry-pi-os/raspbian/ buster main non-free contrib rpi
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspberry-pi-os/raspbian/ buster main non-free contrib rpi

# `/etc/apt/sources.list.d/raspi.list`
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui


## yarn, npm
npm install -g yrm
npm install -g nrm
