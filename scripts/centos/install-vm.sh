# https://github.com/jaywcjlove/handbook/blob/master/CentOS/CentOS7%E5%AE%89%E8%A3%85KVM%E8%99%9A%E6%8B%9F%E6%9C%BA%E8%AF%A6%E8%A7%A3.md

# Update libosinfo to use `--os-variant` Ubuntu 18.04 automaticlly
sudo yum update libosinfo
osinfo-query os | grep ubuntu

# Install vm
sudo virt-install \
--virt-type=kvm \
--name=ubuntu1804 \
--vcpus=2 \
--memory=4096 \
--location=https://mirrors.tuna.tsinghua.edu.cn/ubuntu/dists/bionic/main/installer-amd64/ \
--os-variant=ubuntu18.04 \
--disk path=/home/vm-discourse/ubuntu1804.qcow2,size=100,format=qcow2 \
--network bridge=br0 \
--graphics none \
--force
