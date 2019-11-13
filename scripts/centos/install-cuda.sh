# Rules:
# 1. NVIDIA GPU in this list: https://developer.nvidia.com/cuda-gpus
# 2. Your NVIDIA Driver may not support latest CUDA: https://docs.nvidia.com/deploy/cuda-compatibility/index.html#binary-compatibility__table-toolkit-driver
# 3. Your CUDA may not support latest framework:
#   - PyTorch: https://pytorch.org/get-started/previous-versions/
#   - Tensorflow: https://www.tensorflow.org/install/source#gpu
# *4. !Best practice! use conda or refer to the choices of conda: https://anaconda.org/pytorch/pytorch/files?sort=ndownloads&sort_order=desc

# Resources:
# 1. CUDA: https://developer.nvidia.com/cuda-downloads
# 2. cuDNN: https://developer.nvidia.com/rdp/cudnn-download

# Commands:
# - check NVIDIA Driver version
nvidia-smi
# - check pytorch & used cuda:
python -c "import torch; print('---\nPyTorch version:', torch.__version__, '\nCurrent CUDA version used in PyTorch:', torch.version.cuda)"


# - install CUDA locally:
#   (You should check Rules#2 before installing)
sh ./cuda_10.0.130_410.48_linux.run --extract <some_dir>
cd <some_dir>
./cuda-linux.10.0.130-24817639.run o-prefix=<install_location>

# - install cuDNN
# https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#installlinux-tar
cp cuda/include/cudnn.h ~/.local/cuda-10.0/include
cp cuda/lib64/libcudnn* ~/.local/cuda-10.0/lib64
chmod a+r ~/.local/cuda-10.0/include/cudnn.h ~/.local/cuda-10.0/lib64/libcudnn*
