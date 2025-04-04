FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04



# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

# Install python and tools
RUN apt-get update && apt-get install -y \
      python3 \
      python3-pip \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update python tools
RUN pip --no-cache-dir install -q --upgrade pip setuptools wheel

# Make python 3 default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 100

