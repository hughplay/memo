# == Best Terminal in Windows ==

# 1. Install a WSL distribution
# If you don't have windows store, install it with: https://github.com/kkkgo/LTSC-Add-MicrosoftStore
# Enable Windows Subsystem for Linux (WSL) in PowerShell with admistration's permission
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Install a Linux Distribution from Windows Store, e.g: Ubuntu 18.04 LTS

# 2. Install Hyper.js
# Install hyper.js as Terminal (Best choice!): https://hyper.is/
# Install drcula theme with config file: https://draculatheme.com/hyper
# Make Hyper launch with WSL: Edit -> Preferences,
#   shell: 'C:\\Windows\\System32\\bash.exe'
# If you prefer to use ZSH
#   shell: 'C:\\Windows\\System32\\wsl.exe',
#   shellArgs: [],

# True Color Detection: https://gist.github.com/XVilka/8346728
printf "\x1b[${bg};2;${red};${green};${blue}m\n"
# Install Powerline font, e.g. Monaco for Powerline: https://github.com/hughplay/fonts
# Change the font-family in Hyper's config file.
# Now use the script for Ubuntu instead: https://github.com/hughplay/env/blob/master/scripts/ubuntu/install.sh
# Port is shared with the main system, e.g. http-server

# == Other Tools ==
# Windows monitoring (like iStat): https://entropy6.com/xmeters/
