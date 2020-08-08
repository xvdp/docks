
# Installation instructions, docker with CUDA
### [main](README.md)

1. remove everything to do with nvidia from machine

```bash
sudo apt-get purge nvidia*
sudo apt-get autoremove
# list apts
sudo apt list --installed | grep nvidia
sudo apt list --installed | grep nccl
sudo apt list --installed | grep cuda
sudo apt list --installed | grep cudnn
# any that show up delete from
sudo apt remove <...> && sudo apt-get autoremove
# list apt sources, emove any that make mention to NVIDIA, CUDA, CUDNN
ls /etc/apt/sources.list.d/
reboot
```
2. Install driver, these should be backwards compatible
```bash
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
ubuntu-drivers devices # will list avaliable
#as of writing of this doc install latest ->
sudo apt install nvidia-driver-450 # cuda 11
# or older drivers
# sudo apt install nvidia-driver-440 # cuda 10.2
# sudo apt install nvidia-driver-435 # cuda 10.1
```

3. Install docker if you dont have it already
```bash
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

4. Install NVIDIA docker toolkit. If driver is reinstalled, reinstall this as well, from https://github.com/NVIDIA/nvidia-docker#ubuntu-160418042004-debian-jessiestretchbuster
```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

5. Modify Dockerfile and runfiles:
* working directory default is `~/work`, listed both in `cudagl??.?_conda/Dockerfile` and in `run_pt?.?_tf?.??_cudagl??.?.sh`
* run files contain user folders, modify.

6. Create the appropriate CudaGL environment (cuda, ogl, conda) and full docker container, then run, e.g.
```bash
cd cudagl10.2_conda && build.sh && cd ../pt1.6_tf2.2_cudagl10.2 && build.sh 
run.sh # to run with jupyter or
run.sh -b 1 #run with bash
# or run the bash from docks/run_pt1.6_tf2.2_cudagl10.2.sh modifying working and data dirs
```

7. add path to ~/.bashrc
`export PATH="$PATH:/home/z/work/docks"`


