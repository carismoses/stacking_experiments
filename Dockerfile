# Use an official Python runtime as a parent image
FROM nvidia/cuda:9.0-runtime-ubuntu16.04

# Install python 3.7
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.7
RUN apt-get install -y python3.7-dev
RUN apt-get install -y python3-pip
RUN apt-get install -y git

# make python 3.7 the default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2
RUN update-alternatives  --set python /usr/bin/python3.7

# Install pb_robot
RUN python3.7 -m pip install numpy pybullet recordclass catkin_pkg IPython networkx scipy numpy-quaternion
RUN python3.7 -m pip install git+https://github.com/mike-n-7/tsr.git
RUN git clone https://github.com/mike-n-7/pb_robot.git
WORKDIR /pb_robot/src/pb_robot/ikfast/franka_panda
RUN python3.7 setup.py build

# Install pddlstream
RUN apt-get update
RUN apt-get install -y cmake g++ g++-multilib make python
WORKDIR /
RUN git clone https://github.com/caelan/pddlstream.git
WORKDIR /pddlstream
RUN git submodule update --init --recursive
RUN ./FastDownward/build.py

# install nano 
RUN apt-get update
RUN apt-get install -y nano

# install minio client
WORKDIR /
RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc

# install stacking requirements (clone repo to get requirements file, then remove)
RUN git clone https://github.com/Learning-and-Intelligent-Systems/stacking.git
RUN mv /stacking/requirements.txt .
RUN rm -r stacking
RUN python3.7 -m pip install --upgrade pip
RUN xargs -n1 python3.7 -m pip install install --trusted-host pypi.python.org < requirements.txt
RUN python3.7 -m pip install matplotlib torch sklearn numba
# install torch version with right CUDA version (10.1) for lis-cloud GPUs 
RUN python3.7 -m pip install --default-timeout=100 torch==1.5.1+cu101 torchvision==0.6.1+cu101 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3.7 -m pip install pyquaternion
