# install google Cloud SDK
https://cloud.google.com/sdk/docs/quickstart

# GCP Panel
https://console.cloud.google.com/cloud-resource-manager?_ga=2.200642798.1754256613.1614189145-1768861463.1613408877&pli=1&authuser=3

# create a cluster (mnosew-cluster-1 was already there for me)
https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster

# enable the cloud registry api (where to push container images)
https://console.cloud.google.com/flows/enableapi?apiid=containerregistry.googleapis.com&redirect=https:%2F%2Fcloud.google.com%2Fcontainer-registry%2Fdocs%2Fquickstart&_ga=2.114287685.334493186.1614368248-1768861463.1613408877&angularJsUrl=%2Fflows%2Fenableapi%3Fapiid%3Dcontainerregistry.googleapis.com%26redirect%3Dhttps:%2F%2Fcloud.google.com%2Fcontainer-registry%2Fdocs%2Fquickstart%26_ga%3D2.114287685.334493186.1614368248-1768861463.1613408877&authuser=3&project=&folder=&organizationId=

# Updating Docker Image
Every time the code changes, rebuild the Docker file and upload it to gcr:

docker build -t honda-cmm .
docker tag honda-cmm:latest gcr.io/robustroboticsgroup-225320/mnosew-honda-cmm
docker push gcr.io/robustroboticsgroup-225320/mnosew-honda-cmm

# Interfacing with Kubernetes
To deploy a job, create a .yaml file like kube.yaml. Then run:
kubectl apply -f kube.yaml

Only one job with a given name can exist:
kubectl delete -f kube.yaml

To get more info:
kubectl describe -f kube.yaml

The above command will state a pod name:
kubectl logs <podname>

# Creating GPU worker pool
First create the node pool:
gcloud container node-pools create mnosew-k80-pool-1 --accelerator type=nvidia-tesla-k80,count=1 --zone us-central1-a --cluster mnosew-cluster-1 --num-nodes 2 --min-nodes 0 --max-nodes 4 --enable-autoscaling --machine-type n1-standard-8
Then install the nvidia drivers:
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/master/nvidia-driver-installer/cos/daemonset-preloaded.yaml
More details here: https://cloud.google.com/kubernetes-engine/docs/how-to/gpus#installing_drivers

# Creating a CPU worker pool
gcloud container node-pools create mnosew-cpu-pool-1 --zone us-central1-a --cluster mnosew-cluster-1 --num-nodes 1 --min-nodes 1 --max-nodes 16 --enable-autoscaling --machine-type n1-standard-16

# get all events
kubectl get events --sort-by='.lastTimestamp'

# get events for just a single pod
kubectl get event --namespace default --field-selector involvedObject.name=my-pod-zl6m6

kubectl get event --namespace default --field-selector involvedObject.name=my-pod-zl6m6

# get cluster information (how many nodes in cluster)
gcloud container clusters list
gcloud container node-pools describe mnosew-k80-pool-1 --cluster mnosew-cluster-1
    
# add nodes
gcloud container clusters resize mnosew-cluster-1 --node-pool mnosew-k80-pool-1 --num-nodes 6

# increase max nodes?
gcloud container clusters update mnosew-cluster-1 --enable-autoscaling \
    --min-nodes 0 --max-nodes 6 --zone us-central1-a --node-pool mnosew-k80-pool-1

# delete stubborn pods
kubectl get pods --all-namespaces
kubectl get deployment -n (namespacename) --> podname
kubectl delete deployment (podname) -n (namespacename)
