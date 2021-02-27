#!/bin/sh

rm yaml_files/*
sleep 3

############
cluster='lis' # gcp or lis
runs='2'
############

if [ ${cluster} == 'lis' ]; then
    image='carismoses\/stacking-train:latest'
fi
if [ ${cluster} == 'gcp' ]; then
    image='gcr.io\/robustroboticsgroup-225320\/carism-stacking-train'
fi

# sampling strategy comparisons
noise='1'
strategies='subtower subtower-greedy bald'
sa='sequential'
model_type='fcgn'
for st in $strategies
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
      sed -i "" "s/<IMAGE>/${image}/g" $new_yaml
    done
done

st='bald'
sa='random'
model_type='fcgn'
for r in $runs
do
  new_yaml=yaml_files/${st}-${sa}-${model_type}-${r}.yaml
  cp train_template.yaml $new_yaml
  sed -i "" "s/<ST>/${st}/g" $new_yaml
  sed -i "" "s/<SA>/${sa}/g" $new_yaml
  sed -i "" "s/<MT>/${model_type}/g" $new_yaml
  sed -i "" "s/<RUN>/${r}/g" $new_yaml
  sed -i "" "s/<N>/${noise}/g" $new_yaml
  sed -i "" "s/<IMAGE>/${image}/g" $new_yaml
done

# architecture comparison
strategy='subtower'
sampler='sequential'
model_types='fcgn-fc fcgn lstm'
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
    sed -i "" "s/<IMAGE>/${image}/g" $new_yaml
  done
done