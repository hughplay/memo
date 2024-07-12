# Prepare GPUs for deep learning
# Note: This script is not meant to be run directly. .sh is just for syntax highlighting.
#       Please copy the command you need and run it in the shell one by one.

sudo timedatectl set-timezone "Asia/Shanghai"

# change locale
sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales
# or directly edit /etc/default/locale and then !reboot!
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Add user
sudo adduser xxx
sudo passwd xxx
sudo usermod -aG sudo xxx


# Basic packages for Ubuntu
# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo vim /etc/apt/sources.list
""" Ubuntu 20.04
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
"""

# Issue: Certificate verification failed, https://github.com/tuna/issues/issues/1342
# Solution 1: change https to http 
# Solution 2: update ca-certificates first:
sudo apt-get install --only-upgrade ca-certificates

sudo apt-get update && sudo apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
    build-essential \
    cmake \
    g++-7 \
    git \
    curl \
    vim \
    wget \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    librdmacm1 \
    libibverbs1 \
    ibverbs-providers \
    zsh \
    tzdata \
    libgl1-mesa-glx \
    libglib2.0-0
    zip \
    unzip \
    rsync \
    htop \
    language-pack-en \
    nethogs \
    sysstat \
    gnupg \
    lsb-release


# Install Nvidia Driver - Ubuntu 20.04
# https://developer.nvidia.com/cuda-downloads
wget https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run
sudo sh cuda_11.6.2_510.47.03_linux.run
"""
===========
= Summary =
===========

Driver:   Installed
Toolkit:  Installed in /usr/local/cuda-11.6/

Please make sure that
 -   PATH includes /usr/local/cuda-11.6/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-11.6/lib64, or, add /usr/local/cuda-11.6/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-11.6/bin
To uninstall the NVIDIA Driver, run nvidia-uninstall
Logfile is /var/log/cuda-installer.log
"""
# Issue: WARNING: An NVIDIA kernel module 'nvidia' appears to be already loaded in your kernel.
sudo lsof /dev/nvidia*

# Install Nvidia Driver - Ubuntu 18.04
# https://developer.nvidia.com/cuda-downloads
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda


# Install v2ray as you may need :)
# https://github.com/v2fly/v2ray-core/releases/latest
wget https://hub.fastgit.xyz/v2fly/v2ray-core/releases/download/v4.44.0/v2ray-linux-64.zip
unzip v2ray-linux-64.zip -d v2ray && sudo cp v2ray/v2ray v2ray/v2ctl /usr/local/bin
v2ray -c config.json
export http_proxy="http://127.0.0.1:8001" https_proxy="http://127.0.0.1:8001"


# Tmux & Tmux configuration
sudo apt-get install -y libevent-dev ncurses-dev automake pkg-config \
    && cd /tmp \
    && wget -O tmux-2.8.tar.gz https://github.com/tmux/tmux/archive/2.8.tar.gz \
    && tar zxvf tmux-2.8.tar.gz \
    && cd tmux-2.8 \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local \
    && make \
    && sudo make install \
    && rm -rf /tmp/tmux-2.8 /tmp/tmux-2.8.tar.gz
git clone https://github.com/hughplay/tmux-config.git /tmp/tmux-config \
    && bash /tmp/tmux-config/install.sh \
    && rm -rf /tmp/tmux-config \
    && echo "set -g default-shell `which zsh`" >> ~/.tmux.conf


# ZSH configuration
curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash -s -- --unattended
wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -O ${ZSH:-~/.oh-my-zsh}/themes/honukai.zsh-theme --no-check-certificate \
    && sed -i.bak '/ZSH_THEME/s/\".*\"/\"honukai\"/' ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH:-~/.oh-my-zsh}/custom/plugins/zsh-autosuggestions\
    && sed -i.bak '/plugin/s/(.*)/(git zsh-autosuggestions)/' ~/.zshrc
# ZSH as default shell
chsh -s "$(command -v zsh)" "${USER}"

"""
# Install Miniconda
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/install-conda.sh \
    && chmod +x /tmp/install-conda.sh \
    && /tmp/install-conda.sh -b -p $HOME/.miniconda \
    && rm -f /tmp/install-conda.sh \
    && export PATH="$HOME/.miniconda/bin:$PATH" \
    && conda init \
    && cat <<EOT >> ~/.condarc
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
EOT
"""

conda install -y python=3.8
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install gpustat
sudo nvidia-smi daemon
gpustat -i 0.3

# PyTorch stable wheels mirror: https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html
pip install torch==1.10.1+cu111 torchvision==0.11.2+cu111 torchaudio==0.10.1+cu111 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html

# Install docker
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker
# https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker $USER
# relogin or run:
newgrp docker
# test
docker run hello-world

# add proxy for docker
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
"""
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:8080/"
Environment="HTTPS_PROXY=https://proxy.example.com:8080/"
"""
sudo systemctl daemon-reload


# Install nvidia-docker2
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
# test
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi


# docker pull through proxy: method 1
sudo mkdir /etc/systemd/system/docker.service.d
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:8001/"
Environment="HTTPS_PROXY=http://127.0.0.1:8001/"
sudo systemctl daemon-reload
sudo systemctl restart docker

# docker pull through proxy: method 2
sudo mkdir /etc/docker
sudo vim /etc/docker/daemon.json
{
  "proxies": {
    "default": {
      "httpProxy": "http://127.0.0.1:8001",
      "httpsProxy": "https://127.0.0.1:8001",
      "noProxy": "localhost,127.0.0.1"
    }
  }
}
sudo service docker restart

# check the disk
lsblk
# Format & Mount disk
sudo mkfs.ext4 /dev/sdx
lsblk -f
sudo mkdir <mount_point>
sudo vim /etc/fstab
# UUID=<uuid> <mount_point> ext4 defaults 0 0
sudo mount -a

# use LVM to merge two disks into one logical volume
# Install necessary software packages
sudo apt-get install mdadm lvm2
# Create a RAID array
sudo mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/nvme1n1 /dev/nvme0n1
# Verify RAID array creation
cat /proc/mdstat
# Initialize LVM on the RAID array
sudo pvcreate /dev/md0
# Create a volume group (VG)
sudo vgcreate <vg-name> /dev/md0
# Create a logical volume (LV) within the volume group
sudo lvcreate -n <lv-name> -l 100%FREE <vg-name>
# Format the logical volume with a file system
sudo mkfs.ext4 /dev/<vg-name>/<lv-name>
# Create a mount point for the logical volume
sudo mkdir /mnt/<mount-point>
# Mount the logical volume
sudo mount /dev/<vg-name>/<lv-name> /mnt/<mount-point>
# Update /etc/fstab to automatically mount the logical volume
sudo nano /etc/fstab
# Add the following line to the end of the file:
# /dev/<vg-name>/<lv-name>   /mnt/<mount-point>   ext4   defaults   0 0
# Save the changes and exit the text editor
# Reboot the server to apply the changes and verify the mount
sudo reboot

# nvidia-smi hangs issue
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
sudo reboot -f


## server monitoring with netdata

# install netdata
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry

# change hostname
cd /etc/netdata 2>/dev/null || cd /opt/netdata/etc/netdata
sudo update-alternatives --config editor  # select vim if you need
# [global]
# hostname: xxx
sudo systemctl restart netdata

# enable nvidia-smi
sudo ./edit-config go.d.conf
# nvidia_smi: yes
sudo systemctl restart netdata

# collect data from multiple servers to the center server
# https://learn.netdata.cloud/docs/streaming/understanding-how-streaming-works#enable-streaming-on-the-parent-node
# (parent)
uuidgen
sudo ./edit-config stream.conf
# replace [API_KEY] with [<uuidgen result>]
[<uuidgen result>]
    enabled = yes
    default memory mode = dbengine
# (child)
[stream]
    enabled = yes 
    destination = <parent IP>
    api key = <uuidgen of parent>


# umount busy disks: https://stackoverflow.com/questions/7878707/how-to-unmount-a-busy-device
