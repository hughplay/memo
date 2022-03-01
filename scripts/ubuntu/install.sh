#!/bin/bash
# Tested on Ubuntu 16.04

# set locale, checked
export LC_ALL="en_US.UTF-8"
sudo locale-gen "en_US.UTF-8"


# Install Base Tools, checked
sudo apt-get update && sudo apt-get install -y \
        g++ \
        cmake \
        curl \
        wget \
        git \
        zsh \
        tzdata \
        locales \
        libevent-dev \
        ncurses-dev \
        autotools-dev \
        automake \
        nautilus \
        tree

# (Internet) Install tmux, checked
sudo bash <(curl -s https://raw.githubusercontent.com/hughplay/env/master/scripts/ubuntu/install_tmux_x.sh)

# Use zsh as default, checked
command -v zsh | sudo tee -a /etc/shells \
    && sudo chsh -s "$(command -v zsh)" "${USER}"

# (Internet) Zsh config: 1. oh-my-zsh 2. honukai
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh --no-check-certificate \
    && sh /tmp/install-oh-my-zsh.sh --unattended \
    && rm -f /tmp/install-oh-my-zsh.sh \
    && wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -O ~/.oh-my-zsh/themes/honukai.zsh-theme --no-check-certificate \
    && sed -i.bak '/ZSH_THEME/s/\".*\"/\"honukai\"/' ~/.zshrc\
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions\
    && sed -i.bak '/plugin/s/(.*)/(git zsh-autosuggestions)/' ~/.zshrc

# (Internet) Use localrc: common used alias
# wget https://raw.githubusercontent.com/hughplay/env/master/workbench/.localrc -O $HOME/.localrc \
#     && echo 'source $HOME/.localrc' >> $HOME/.zshrc

# (ppa:neovim-ppa/stable, 502 Bad GateWay), checked
# make sure you have set http_proxy and https_proxy correctly if you need to
# or you will get `ERROR: '~neovim-ppa' user or team does not exist`.
# sudo apt-get install -y software-properties-common \
#     && sudo add-apt-repository -y ppa:neovim-ppa/unstable \
#     && sudo apt-get update \
#     && sudo apt-get install -y neovim \
#     && pip install neovim --user

# (Internet) Tmux config, checked
git clone https://github.com/hughplay/tmux-config.git /tmp/tmux-config \
    && bash /tmp/tmux-config/install.sh \
    && rm -rf /tmp/tmux-config

# Vim config: lightvim
wget https://raw.githubusercontent.com/hughplay/lightvim/master/install.sh -O - | sh

# ====================
#   Useful Snippets
# ====================

# > set timezone
: <<'comment'
sudo ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
comment

# > Vim to Nvim
: <<'comment'
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
comment

# > Install powerline fonts (For local use, not needed on server)
: <<'comment'
git clone https://github.com/hughplay/fonts.git /tmp/fonts --depth=1 \
    && sh /tmp/fonts/install.sh \
    && cd \
    && rm -rf /tmp/fonts
comment

# > (Internet) Install Miniconda: python 3.6, checked
: <<'comment'
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/install-conda.sh \
    && chmod +x /tmp/install-conda.sh \
    && /tmp/install-conda.sh -b -p $HOME/.miniconda \
    && echo 'export PATH="$HOME/.miniconda/bin:$PATH"' >> $HOME/.localrc \
    && rm -f /tmp/install-conda.sh \
    && export PATH="$HOME/.miniconda/bin:$PATH" \
    && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ \
    && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ \
    && conda config --set show_channel_urls yes \
    && conda install -y python=3.6 \
    && pip install ipython --user
comment

# > Node & yarn
: <<'comment'
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt install nodejs
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
comment

# docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker

# mDNS
# https://gist.github.com/davisford/5984768
sudo apt-get install avahi-daemon avahi-discover avahi-utils libnss-mdns mdns-scan
