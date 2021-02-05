# Failed to initialize NVML: Driver/library version mismatch.
# https://comzyh.com/blog/archives/967/
sudo rmmod nvidia
[To make `sudo rmmod nvidia` success, you may need]
sudo lsmod | grep nvidia
sudo rmmod nvidia_modeset
......
nvidia-smi

# Install Nvidia Drivers
# https://www.programmersought.com/article/31361169634/
rm -f /tmp/.X0.lock
# kernel-header, kernel-devel version must match `uname -r` (search & download rpm packages manually)
rpm -i xxx.rpm


#  Error: missing or unsuitable terminal
cp -r /usr/share/terminfo ~/.terminfo
