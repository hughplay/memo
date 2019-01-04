#!/bin/bash
# Tested on Ubuntu 16.04

echo "Make sure the Internet is avaiable!"

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
git clone https://github.com/tmux/tmux.git /tmp/tmux \
    && cd /tmp/tmux \
    && git checkout tags/2.7 \
    && sh autogen.sh \
    && ./configure && make \
    && sudo mv tmux /usr/bin/tmux \
    && cd \
    && rm -rf /tmp/tmux

# Use zsh as default, checked
command -v zsh | sudo tee -a /etc/shells \
    && sudo chsh -s "$(command -v zsh)" "${USER}"

# (Internet) Zsh config: 1. oh-my-zsh 2. honukai
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh \
    && sed -i '/env zsh/d' /tmp/install-oh-my-zsh.sh \
    && sed -i 's/chsh -s/sudo chsh -s/g' /tmp/install-oh-my-zsh.sh \
    && sh /tmp/install-oh-my-zsh.sh \
    && rm -f /tmp/install-oh-my-zsh.sh \
    && wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -O ~/.oh-my-zsh/themes/honukai.zsh-theme \
    && sed -i.bak '/ZSH_THEME/s/\".*\"/\"honukai\"/' ~/.zshrc

# (Internet) Use localrc: common used alias
wget https://raw.githubusercontent.com/hughplay/env/master/workbench/.localrc -O $HOME/.localrc \
    && echo 'source $HOME/.localrc' >> $HOME/.zshrc

# (ppa:neovim-ppa/stable, 502 Bad GateWay), checked
# make sure you have set http_proxy and https_proxy correctly if you need to
# or you will get `ERROR: '~neovim-ppa' user or team does not exist`.
sudo apt-get install -y software-properties-common \
    && sudo add-apt-repository -y ppa:neovim-ppa/unstable \
    && sudo apt-get update \
    && sudo apt-get install -y neovim \
    && pip install neovim --user

# (Internet) Tmux config, checked
git clone https://github.com/hughplay/tmux-config.git /tmp/tmux-config \
    && zsh /tmp/tmux-config/install.sh \
    && rm -rf /tmp/tmux-config

# Vim config: modified spf13-vim, checked
curl https://raw.githubusercontent.com/hughplay/spf13-vim/3.0/bootstrap.sh -L -o - | bash \
    && cd $HOME/.vim/bundle/YouCompleteMe \
    && python install.py

# ====================
#   Useful Snippets
# ====================

# > set timezone
: <<'comment'
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
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

# > (Internet) Install Miniconda: python 3.5, checked
: <<'comment'
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/install-conda.sh \
    && chmod +x /tmp/install-conda.sh \
    && /tmp/install-conda.sh -b -p $HOME/.miniconda \
    && echo 'export PATH="$HOME/.miniconda/bin:$PATH"' >> $HOME/.localrc \
    && rm -f /tmp/install-conda.sh \
    && export PATH="$HOME/.miniconda/bin:$PATH" \
    && conda install -y python=3.5 \
    && pip install ipython --user
comment

# > Conda mirror
: <<'comment'
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
comment
