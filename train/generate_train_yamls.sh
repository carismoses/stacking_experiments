#!/bin/sh

docker_id='carismoses'

# active learning ablations
strategies='bald random'
samplers='sequential random'
model_type='fcgn'
runs='0 1 2 3 4'
noise='1'
for st in $strategies
do
  for sa in $samplers
  do
    for r in $runs
    do
      new_yaml=yaml_files/${st}-${sa}-${model_type}-${r}.yaml
      cp train_template.yaml $new_yaml
      sed -i "" "s/<ST>/${st}/g" $new_yaml
      sed -i "" "s/<SA>/${sa}/g" $new_yaml
      sed -i "" "s/<MT>/${model_type}/g" $new_yaml
      sed -i "" "s/<RUN>/${r}/g" $new_yaml
      sed -i "" "s/<N>/${noise}/g" $new_yaml
      sed -i "" "s/<DOCKERID>/${docker_id}/g" $new_yaml
    done
  done
done

# architecture comparison
strategy='bald'
sampler='sequential'
model_types='fcgn-fc fcgn lstm'
runs='0 1 2 3 4'
for mt in $model_types
do
  for r in $runs
  do
    new_yaml=yaml_files/${strategy}-${sampler}-${mt}-${r}.yaml
    cp train_template.yaml $new_yaml
    sed -i "" "s/<ST>/${strategy}/g" $new_yaml
    sed -i "" "s/<SA>/${sampler}/g" $new_yaml
    sed -i "" "s/<MT>/${mt}/g" $new_yaml
    sed -i "" "s/<RUN>/${r}/g" $new_yaml
    sed -i "" "s/<N>/${noise}/g" $new_yaml
    sed -i "" "s/<DOCKERID>/${docker_id}/g" $new_yaml
  done
done