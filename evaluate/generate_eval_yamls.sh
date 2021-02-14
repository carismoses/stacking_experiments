#!/bin/sh

docker_id='carismoses'
exp_paths='bald-sequential-fcgn-0-20210211-210108
bald-random-fcgn-0-20210211-210106
bald-sequential-fcgn-fc-0-20210211-210107
bald-sequential-lstm-0-20210211-210109
random-random-fcgn-0-20210211-210115
random-sequential-fcgn-0-20210211-210115'

#bald-random-fcgn-1-20210212-022300
#bald-sequential-fcgn-1-20210211-210142
#bald-sequential-fcgn-fc-1-20210212-070331
#bald-sequential-lstm-1-20210212-022311
#random-random-fcgn-1-20210212-064136
#random-sequential-fcgn-1-20210212-034043

#bald-random-fcgn-2-20210212-111112
#bald-sequential-fcgn-2-20210212-065356
#bald-sequential-fcgn-fc-2-20210212-022250
#bald-sequential-lstm-2-20210212-071252
#random-random-fcgn-2-20210212-022307
#random-sequential-fcgn-2-20210212-112223

#bald-random-fcgn-3-20210212-080530
#bald-sequential-fcgn-3-20210212-064022
#bald-sequential-fcgn-fc-3-20210212-022258
#bald-sequential-lstm-3-20210212-085852
#random-random-fcgn-3-20210212-133148
#random-sequential-fcgn-3-20210212-022252'

problems='tallest'
# min-contact overhang'

for exp in $exp_paths
do
  for p in $problems
  do
    new_yaml=yaml_files/${exp}-${p}.yaml
    cp eval_template.yaml $new_yaml
    sed -i "" "s/<EXP>/${exp}/g" $new_yaml
    sed -i "" "s/<P>/${p}/g" $new_yaml
    sed -i "" "s/<DOCKERID>/${docker_id}/g" $new_yaml
  done
done