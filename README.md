# stacking_experiments

This assumes you have CUDA version 10.1 on your GPU device, although you can also
train (very slowly) on a CPU

To train with kubernetes:
1. cd into /train
2. generate kubernetes yaml files
    1. open generate_train_yamls.sh and set the desired run number (we did 5 runs of each method for the paper)
    2. select where the training will be run (lis or rrg)
    3. run generate_train_yamls.sh to generate the yaml files
3. run the experiment with: kubectl apply -f relevant_yaml_exp_file
    1. for active learning these will be in train/yaml_files run
4. stop pod with: kubectl delete -f relevant_yaml_exp_file

To train on Google Cloud VM
1. spin up a VM using the command in create-vm (use a distinct INSTANCE_NAME)
2. ssh into VM using command in gcp_setup
3. in VM: git clone https://github.com/carismoses/stacking_experiments.git
4. run with the relevant SPECIFIC_ENV_FILE.list: docker run --runtime nvidia --env-file stacking_experiments/train/env_var_files/SPECIFIC_ENV_FILE.list carismoses/stacking-train:latest
    other optional args: --env CUDA_VISIBLE_DEVICES=$DEVICE_NUM
                         --name $NAME
5. To kill a VM instance: 

To evaluate with kubernetes:
1. cd into /evaluate
2. generate kubernetes yaml files
    1. open generate_eval_yamls.sh
    2. in the exp_path list variable, list all of the experiment directories to be evaluated (the name of the directory in minio)
3. kubectl apply -f yaml_files/relevant_yaml_exp_file
4. stop pod with: kubectl delete -f yaml_files/relevant_yaml_exp_file

To run an experiment with docker:
1. set env variables in relevant .sh file (train/train.sh or evaluate/eval.sh)
2. rebuild docker image (train/Dockerfile or evaluate/Dockerfile)
3. run (local) or push and run (remote)
NOTE: the bash files are set up to copy results to minio, you might have to comment this out

Experiment Naming
strategy: random, bald, subtower, subtower-greedy
sampler: sequential, random
model_type: fcgn-fc, fcgn, lstm
run: 0, 1, 2, 3, 4
filename: strategy-sampler-model-type-run.yaml

NOTE:
1. The base image (carismoses/stacking:latest) used in train/Dockerfile and evaluate/Dockerfile are up to date and pushed to dockerhub, so you should only need to make changes to train/Dockerfile and evaluating/Dockerfile
2. You will probably only need to make changes in train.sh and eval.sh. Then rebuild the relevant Dockerfile
(and push to your own Dockerhub if running remotely)

## Docker Guide

### build base stacking image
`docker build --tag=carismoses/stacking:latest .`

### build stacking training image
`docker build --tag=carismoses/stacking-train:latest .`

### build stacking evaluating image
`docker build --tag=carismoses/stacking-eval:latest .`

### push relevant image
`docker push relevant_image_tag`

### pull relevant image
`docker pull relevant_image_tag`

### run containers
gpu: `docker run --runtime nvidia relevant_image_tag`
cpu: `docker run relevant_image_tag`

### run in interactive shell (mostly for debugging)
gpu: `docker run -it --runtime nvidia relevant_image_tag /bin/bash`
cpu: `docker run -it relevant_image_tag /bin/bash`