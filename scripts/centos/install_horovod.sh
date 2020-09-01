# Install gcc
conda install -c psi4 gcc-5
# Or build gcc
# download gcc source code
./contrib/download_prerequisites
./configure --prefix ~/.local/ --disable-multilib && make && make install

# Install Open MPI
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.3.tar.gz
tar zxvf openmpi-4.0.3.tar.gz && cd openmpi-4.0.3
./configure --prefix ~/.local/ && make && make install

# https://docs.nvidia.com/deeplearning/nccl/install-guide/index.html#softreq
# Download NCCL2: https://developer.nvidia.com/nccl/getting_started (tgx)
#  - Login
#  - O/S agnostic local installer
tar xvf <tgx> <eg. ~/.local/>

HOROVOD_NCCL_HOME=<nccl_home> HOROVOD_GPU_OPERATIONS=NCCL HOROVOD_CUDA_HOME=<cuda_home> pip install --no-cache-dir horovod

# PyTorch: https://horovod.readthedocs.io/en/latest/pytorch.html
import horovod.torch as hvd
hvd.init()
torch.cuda.set_device(hvd.local_rank())
train_sampler = torch.utils.data.distributed.DistributedSampler(
    train_dataset, num_replicas=hvd.size(), rank=hvd.rank())
train_loader = torch.utils.data.DataLoader(train_dataset, batch_size=..., sampler=train_sampler)
optimizer = optim.SGD(lr=config.lr*hvd.size(), model.parameters())
optimizer = hvd.DistributedOptimizer(optimizer, named_parameters=model.named_parameters())
hvd.broadcast_parameters(model.state_dict(), root_rank=0)
hvd.broadcast_optimizer_state(optimizer, root_rank=0)
self.epoch = hvd.broadcast(torch.tensor(self.epoch), root_rank=0).item()

# https://horovod.readthedocs.io/en/latest/mpirun.html
horovodrun -np 4 -H localhost:4 python train.py <args>
mpirun -np 4 \
    -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH \
    -mca pml ob1 -mca btl ^openib \
    python train.py
