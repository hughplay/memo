# pre requirements
# sudo yum install -y autoconf automake ncurses-devel

# Install tmux-2.8
# Use https://github.com/hughplay/env/blob/master/scripts/centos/install-tmux.sh
bash <(curl -s https://raw.githubusercontent.com/hughplay/env/master/scripts/centos/install-tmux.sh)

# Install tmux-config
git clone https://github.com/hughplay/tmux-config.git /tmp/tmux-config \
    && bash /tmp/tmux-config/install.sh \
    && rm -rf /tmp/tmux-config

# Install neovim
# git clone ...
# make CMAKE_EXTRA_FLAGS=-DCMAKE_INSTALL_PREFIX=$HOME/.local

# Install zsh

wget https://github.com/zsh-users/zsh/archive/zsh-5.6.2.tar.gz -O /tmp/zsh-5.6.2.tar.gz \
    && tar zxvf /tmp/zsh-5.6.2.tar.gz -C /tmp \
    && cd /tmp/zsh-zsh-5.6.2/ \
    && ./Util/preconfig \
    && ./configure --prefix=$HOME/.local \
    && make \
    && make install \
    && cd -

wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh --no-check-certificate \
    && sh /tmp/install-oh-my-zsh.sh --unattended \
    && rm -f /tmp/install-oh-my-zsh.sh \
    && wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -O ~/.oh-my-zsh/themes/honukai.zsh-theme --no-check-certificate \
    && sed -i.bak '/ZSH_THEME/s/\".*\"/\"honukai\"/' ~/.zshrc
    
# Change default shell to zsh (need sudo permission)
command -v zsh | sudo tee -a /etc/shells \
    && sudo chsh -s "$(command -v zsh)" "${USER}"
# or change the default shell of tmux (without sudo permission)
echo "set -g default-shell `which zsh`" >> ~/.tmux.conf

# Install latest Miniconda
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/install-conda.sh \
    && chmod +x /tmp/install-conda.sh \
    && /tmp/install-conda.sh -b -p $HOME/.miniconda \
    && echo 'export PATH="$HOME/.miniconda/bin:$PATH"' >> $HOME/.localrc \
    && rm -f /tmp/install-conda.sh \
    && export PATH="$HOME/.miniconda/bin:$PATH" \
    && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ \
    && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ \
    && conda config --set show_channel_urls yes \
    && pip install ipython --user
    
# Install Node
# conda install -y nodejs

# Install htop without sudo permission (sudo yum install -y htop)
# Make sure <conda_home>/lib is in your LD_LIBRARY_PATH
# eg: export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.miniconda/lib"
: <<'comment'
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ \
    && conda install -y -c conda-forge ncurses \
    && git clone https://github.com/hishamhm/htop.git /tmp/htop \
    && cd /tmp/htop \
    && ./autogen.sh \
    && ./configure --prefix=$HOME/.local \
    && make \
    && make install
comment

# vim plugins
# wget https://raw.githubusercontent.com/hughplay/lightvim/master/install.sh -O - | sh

# Add $HOME/.local/bin to your $PATH
echo PATH=$HOME/.local/bin:'$PATH' >> ~/.localrc
sed -i.old '1s;^;source ~/.localrc\n;' ~/.bashrc
sed -i.old '1s;^;source ~/.localrc\n;' ~/.zshrc
