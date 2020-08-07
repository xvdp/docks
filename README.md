# docks
docker build scripts for vrious versions of pytorch and tensorflow with multiple cuda requirements.

* Ubuntu 18.04
* Nvidia driver 450 (CUDA <= 11) or below
* Conda
* pytorch
* tensorflow

### [Installation instructions](INSTALLATION.md)

These dockers create standard environments for pytorch and tensorflow. Using jupyter or bash.
### WIP TODO: serialize installers

## Info
After installation edit run files to point to data and media folders.

Each docker image uses its own ports, so multiple images can run at the same time in a computer.

Docker images create and install into conda environment. Jupyter images start inside the conda environemnt, bash images do not.

Standard aliases are created - specified in  `pt?.?_tf?.?_cudagl??.?/Dockerfile`
* 'ab' activates conda environment inside image
* 'aa' deactivates conda environment
* 'cinit' initializes conda enviroment, pip installing local projects listed in `bash_entry_point.sh`.


## Examples
```bash
# start same image and container in bash
./run_pt1.3_tf1.14_cudagl10.0.sh
```
```bash
# start same image and container in jupyter
./run_pt1.3_tf1.14_cudagl10.0_jupyter.sh
```

