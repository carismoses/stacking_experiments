#!/bin/sh

# clear all yaml files before regenerating
#rm yaml_files/*
#sleep 3

docker_id='carismoses'

# acquisition strategies
exp_paths='bald-random-fcgn-2-20210604-193847
bald-sequential-fcgn-2-20210604-193703
random-random-fcgn-0-20210604-193209
subtower-greedy-sequential-fcgn-2-20210604-193549
subtower-sequential-fcgn-2-20210604-193420
subtower-sequential-fcgn-fc-0-20210604-192732'

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