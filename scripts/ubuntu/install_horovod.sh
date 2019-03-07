# Install PyTorch 1.0.0
pip3 install torch torchvision

# Install NCCL
# Go To https://developer.nvidia.com/nccl , Click Download.
# Get `nccl-repo-ubuntu1604-2.4.2-ga-cuda9.0_1-1_amd64.deb` ready, the version here may be different with yours.
sudo dpkg -i nccl-repo-ubuntu1604-2.4.2-ga-cuda9.0_1-1_amd64.deb
sudo apt-key add /var/nccl-repo-2.4.2-ga-cuda9.0/7fa2af80.pub
sudo apt update
sudo apt install libnccl2 libnccl-dev

# Install OpenMPI
# https://www.open-mpi.org/faq/?category=building#easy-build
mkdir ~/tmp && cd ~/tmp
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.0.tar.gz
gunzip -c openmpi-4.0.0.tar.gz | tar xf -
cd openmpi-4.0.0
./configure --prefix=/usr/local
sudo make all install
sudo ldconfig

# Install horovod
HOROVOD_CUDA_HOME=<path to cuda> HOROVOD_GPU_ALLREDUCE=NCCL pip install --no-cache-dir horovod
