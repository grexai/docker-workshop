# Docker Workshop

This workshop guides you through creating your first Docker project with Python and GPU support.

## Prerequisites
- Docker installed on your machine
- NVIDIA GPU with appropriate drivers (for GPU-accelerated containers)
- [See installation links](#links)

## Testing GPU Availability

Before starting, let's verify that your GPU is available to Docker:

```bash
docker run --rm -it --gpus=all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

If successful, you'll see benchmark results. If not, check your NVIDIA drivers and Docker GPU configuration.

## Working with Docker Images

### Pulling Your First CUDA Image

Find suitable NVIDIA CUDA images on [Docker Hub](https://hub.docker.com/r/nvidia/cuda). Browse the tags to match your CUDA version requirements.

This command downloads the CUDA 11.7.1 image with cuDNN 8 and Ubuntu 20.04.

```bash
docker pull nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
```
check if it is downloaded


```bash
docker image ls 
```
expected output
```console
REPOSITORY                       TAG                               IMAGE ID       CREATED         SIZE
nvidia/cuda                      11.7.1-cudnn8-devel-ubuntu20.04   1d1bfc734455   17 months ago   11.9GB
nvcr.io/nvidia/k8s/cuda-sample   nbody                             59261e419d6d   2 years ago     456MB
```


### Running a Container

Launch a container from the pulled image:

```bash
docker run -dit --name workshop_container nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
```
Where:
- `-d`: Runs in detached mode (background)
- `-i`: Keeps STDIN open 
- `-t`: Allocates a pseudo-TTY
- `--name`: Assigns a name to the container

This command should create a container from the nvidia/cuda image named workshop_container 

Check if the container exists

```bash
docker container ls
```
expected output:
```console
CONTAINER ID   IMAGE                                         COMMAND                  CREATED       STATUS       PORTS     NAMES
ce82d6b2f46b   nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04   "/opt/nvidia/nvidia_…"   4 hours ago   Up 4 hours             workshop_container
```

### Accessing Your Container

Connect to your running container with:

```bash
docker exec -it workshop_container bash
```

This opens an interactive bash shell inside the container.
in the container check for nvidia-smi!

### Enabling GPU Access

By default, containers don't have access to GPUs. To enable GPU access:

```bash
docker run --gpus all -dit --name cuda_container nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
```

## Storages
### Volume
Create a volume

Volumes can be attached to multiple container at once

```docker volume create workshop_vol1```

```bash
docker volume ls
```
```console
DRIVER    VOLUME NAME
local     workshop_vol1
```

Attach the volume to a container:

```bash
docker run --gpus all -dit --name cuda_11.7 -v workshop_vol1:/mnt/workshop nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
```
Volumes can be attached to multiple containers at once.

To copy files to your container use docker cp..
```bash
docker cp local_file.txt workshop_container:/path/in/container/
```

### Bind Mounting Folders

Alternatively, bind mount a folder from your host:

Advantage both host and container will access it however its harder to manage
```bash
docker run --gpus all -dit --name cuda_11.7 -v /abs/path/:/mnt/workshop nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
```

## Building Docker Images

### Using a Dockerfile

Investigate the Dockerfile in the root folder 

```bash
docker build -t workshop_build_file .
```

Run the built image:

```bash
docker run --gpus all -it -v workshop_vol:/workspace workshop_build_file
```

## Docker Compose Example

Investigate `compose.yml`. Docker Compose automatically builds images and creates containers with desired arguments, including:
- NVIDIA GPU support
- Volume attachment
- Bind mounts
build your image and create a container with it
```bash
docker compose up -d
```


Stops containers and removes containers, networks, volumes, and images created by 

```bash
docker compose down
```

### usefull commands
forces to rebuild the image

```bash
docker compose build
```

delete container or image

```bash
docker container rm <name or id>
```

```bash
docker image rm <name or id>
```


### Template builds

Try to use the provided buildfiles and composes as templates:

```
templates/
├── python36_cuda9_cudnn7/
│   ├── Dockerfile
│   └── docker-compose.yml
└── python38_cuda_117_cudnn8/
│   ├── Dockerfile
│   └── docker-compose.yml
└── expanding.../
```


## Links

- [Docker Documentation](https://docs.docker.com/)
- [Windows Install](https://docs.docker.com/desktop/features/wsl/)
- [Linux Install](https://docs.docker.com/engine/install/ubuntu/)
- [Post-installation Steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)
- [NVIDIA Images Hub](https://hub.docker.com/r/nvidia/cuda)
- [CUDA Toolkit for Linux](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

