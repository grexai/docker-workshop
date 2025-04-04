FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

# some program can  ask for  user  input  like  region  selection
# so we set the frontend to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# basic tools 
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev python3-venv\
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# RUN ln -s /usr/bin/python3 /usr/bin/python
# RUN ln -s /usr/bin/pip3 /usr/bin/pip
# Create the virtual environment and set the path
RUN python3 -m venv /venv

# Update python tools
RUN pip --no-cache-dir install -q --upgrade pip setuptools wheel

# add your env to path 
ENV PATH="/venv/bin:$PATH"

# WORKDIR /workspace
# this wont work changes on the volume are not reflected in the container
#RUN git clone https://github.com/grexai/Deep-Regression-plane.git /workspace/Deep-Regression-plane

# RUN mkdir /development/
# # this work since it is not a volume mount
# RUN git clone https://github.com/grexai/Deep-Regression-plane.git /development/Deep-Regression-plane
CMD ["/bin/bash"]
