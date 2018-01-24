# Run script with sudo
# sudo bash install-ubuntu.sh

# Install tmux, zsh
apt-get update && apt-get install -y \
    g++ \
    curl \
    wget \
    git \
    tmux \
    zsh \
    vim

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install honukai.zsh-theme
wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -O ~/.oh-my-zsh/themes/honukai.zsh-theme \
    && sed -i.bak '/ZSH_THEME/s/".*"/"honukai"' ~/.zshrc

# Change default shell to zsh
chsh -s $(which zsh) $USER

# tmux config
git clone --recursive https://github.com/tony/tmux-config.git ~/.tmux \
    && ln -s ~/.tmux/.tmux.conf ~/.tmux.conf \
    && cd ~/.tmux \
    && git submodule init \
    && cd ~/.tmux/vendor/tmux-mem-cpu-load \
    && cmake . \
    && make \
    && make install

# Install powerline fonts
git clone https://github.com/blue-fatty/fonts.git --depth=1 \
    && cd fonts \
    && ./install.sh \
    && cd .. \
    && rm -rf fonts

# Install spf13-vim
curl https://raw.githubusercontent.com/blue-fatty/spf13-vim/3.0/bootstrap.sh -L -o - | sh

# Use local files
curl https://raw.githubusercontent.com/blue-fatty/spf13-vim/3.0/.vimrc.before.local -o - > ~/.vimrc.before.local
curl https://raw.githubusercontent.com/blue-fatty/spf13-vim/3.0/.vimrc.local -o - > ~/.vimrc.local
