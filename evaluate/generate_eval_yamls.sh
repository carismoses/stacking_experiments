#!/bin/sh

# clear all yaml files before regenerating
rm yaml_files/*
sleep 3

docker_id='carismoses'

# acquisition strategies
exp_paths='bald-random-fcgn-1-20210226-190417
bald-sequential-fcgn-1-20210226-230742
subtower-greedy-sequential-fcgn-1-20210226-232246
subtower-sequential-fcgn-1-20210227-085527
subtower-sequential-fcgn-fc-1-20210227-003015
subtower-sequential-lstm-1-20210227-033252'

n_blocks='5'    
problems='tallest min-contact overhang' # tallest min-contact, overhang

for n in $n_blocks
do
    for exp in $exp_paths
    do
      for p in $problems
      do
        new_yaml=yaml_files/${exp}-${n}-${p}.yaml
        cp eval_template.yaml $new_yaml
        sed -i "" "s/<EXP>/${exp}/g" $new_yaml
        sed -i "" "s/<P>/${p}/g" $new_yaml
        sed -i "" "s/<NBLOCKS>/${n}/g" $new_yaml
        sed -i "" "s/<DOCKERID>/${docker_id}/g" $new_yaml
      done
    done
done