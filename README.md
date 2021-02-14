# stacking_experiments

This assumed you have CUDA version 10.1 on your GPU device, although you can also
train (very slowly) on a CPU

# build base stacking image
`docker build --tag=carismoses/stacking:latest .`

# build stacking training image
`docker build --tag=carismoses/stacking-train:latest .`

# build stacking evaluating image
`docker build --tag=carismoses/stacking-eval:latest .`

# push relevant image
`docker push relevant_image_tag`

# pull relevant image
`docker pull relevant_image_tag`

# run containers
gpu: `docker run --runtime nvidia relevant_image_tag`
cpu: `docker run relevant_image_tag`

# run in interactive shell (mostly for debugging)
gpu: `docker run -it --runtime nvidia relevant_image_tag /bin/bash`
cpu: `docker run -it relevant_image_tag /bin/bash`

To run an experiment with kubernetes:
1. cd into the relevant experiment directory
2. change the dockerid and generate yaml files
2. kubectl apply -f train_yamls/relevant_yaml_exp_file
3. stop pod with: kubectl delete -f relevant_yaml_exp_file

To run an experiment with docker:
1. set env variables in relevant .sh file
2. rebuild docker image
3. run (local) or push and run (remote)

Experiment Naming
strategy: sequential, random
sampler: sequential, random
model_type: fcgn-con, fcgn, lstm, mlp
run: 0, 1, 2, 3, 4
filename: strategy-sampler-model-type-run.yaml

NOTE:
1. The base image (carismoses/stacking:latest) used in train/Dockerfile and evaluate/Dockerfile are up to date and pushed to dockerhub, so you should only need to make changes to train/Dockerfile and evaluating/Dockerfile
2. You will probably only need to make changes in train.sh and eval.sh. Then rebuild the relevant Dockerfile
(and push to your own Dockerhub if running remotely)