# On Mac
brew cask install xquartz
# reboot
# ~/.ssh/config
Host *
    ForwardAgent yes
    ForwardX11 yes
    ForwardX11Trusted yes

# On server
# /usr/bin/xauth:  file .Xauthority does not exist
xhost +

# eog, nautils

# VS Code
echo DISPLAY
export DISPLAY='localhost:11.0'
