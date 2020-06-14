# Failed to initialize NVML: Driver/library version mismatch.
# https://comzyh.com/blog/archives/967/
sudo rmmod nvidia
[To make `sudo rmmod nvidia` success, you may need]
sudo lsmod | grep nvidia
sudo rmmod nvidia_modeset
......
nvidia-smi
