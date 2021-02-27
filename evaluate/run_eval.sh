#!/bin/bash

#sleep 10800
for yaml_file in yaml_files/*; do
    kubectl apply -f $yaml_file
done