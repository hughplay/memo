sh ./cuda_10.0.130_410.48_linux.run --extract <some_dir>
cd <some_dir>
./cuda-linux.10.0.130-24817639.run o-prefix=<install_location>

# https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#installlinux-tar
cp cuda/include/cudnn.h ~/.local/cuda-10.0/include
cp cuda/lib64/libcudnn* ~/.local/cuda-10.0/lib64
chmod a+r ~/.local/cuda-10.0/include/cudnn.h ~/.local/cuda-10.0/lib64/libcudnn*
