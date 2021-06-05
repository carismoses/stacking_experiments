#!/bin/sh

# clear all yaml files before regenerating
#rm yaml_files/*
#sleep 3

docker_id='carismoses'

# acquisition strategies
exp_paths='random-random-fcgn-2-20210604-195352
random-random-fcgn-1-20210604-195044'

n_blocks='5'    
problems='tallest min-contact overhang' # tallest min-contact, overhang

for n in $n_blocks
do
    for exp in $exp_paths
    do
      for p in $problems
      do
        new_list=env_var_files/${exp}-${n}-${p}.list
        cp env_vars_template.list $new_list
        sed -i "" "s/<EXP>/${exp}/g" $new_list
        sed -i "" "s/<P>/${p}/g" $new_list
        sed -i "" "s/<NBLOCKS>/${n}/g" $new_list
        sed -i "" "s/<DOCKERID>/${docker_id}/g" $new_list
      done
    done
done