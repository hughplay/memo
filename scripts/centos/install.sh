# Install Miniconda (Python 3.6)
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
    
# Install Node
conda install -y nodejs

# Install tmux-2.8
# Use https://github.com/hughplay/env/blob/master/scripts/centos/install-tmux.sh

# Install tmux-config
git clone https://github.com/hughplay/tmux-config.git /tmp/tmux-config \
    && bash /tmp/tmux-config/install.sh \
    && rm -rf /tmp/tmux-config

# Install neovim
# git clone ...
# make CMAKE_EXTRA_FLAGS=-DCMAKE_INSTALL_PREFIX=$HOME/.local

# Install zsh
sudo yum install -y autoconf

wget https://github.com/zsh-users/zsh/archive/zsh-5.6.2.tar.gz -O /tmp/zsh-5.6.2.tar.gz \
    && tar zxvf /tmp/zsh-5.6.2.tar.gz \
    && cd /tmp/zsh-zsh-5.6.2/ \
    && ./Util/preconfig \
    && ./configure --prefix=$HOME/.local \
    && make \
    && make install \
    && cd -

wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh \
    && sed -i '/env zsh/d' /tmp/install-oh-my-zsh.sh \
    && sed -i 's/chsh -s/sudo chsh -s/g' /tmp/install-oh-my-zsh.sh \
    && sh /tmp/install-oh-my-zsh.sh \
    && rm -f /tmp/install-oh-my-zsh.sh \
    && wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -O ~/.oh-my-zsh/themes/honukai.zsh-theme \
    && sed -i.bak '/ZSH_THEME/s/\".*\"/\"honukai\"/' ~/.zshrc

# htop
# Make sure <conda_home>/lib is in your LD_LIBRARY_PATH
# eg: export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.miniconda/lib"
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ \
    && conda install -y -c conda-forge ncurses \
    && git clone https://github.com/hishamhm/htop.git /tmp/htop \
    && cd /tmp/htop \
    && ./autogen.sh \
    && ./configure --prefix=$HOME/.local \
    && make \
    && make install

# vim plugins
wget https://raw.githubusercontent.com/hughplay/lightvim/master/install.sh -O - | sh
