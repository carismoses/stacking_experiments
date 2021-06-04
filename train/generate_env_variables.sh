#!/bin/sh

rm env_var_files/*
sleep 3

############
runs='2'
############

# sampling strategy comparisons
noise='1'
strategies='subtower subtower-greedy bald'
sa='sequential'
model_type='fcgn'
for st in $strategies
do
    for r in $runs
    do
      new_vars_file=env_var_files/${st}-${sa}-${model_type}-${r}.sh
      cp env_vars_template.sh $new_vars_file
      sed -i "" "s/<ST>/${st}/g" $new_vars_file
      sed -i "" "s/<SA>/${sa}/g" $new_vars_file
      sed -i "" "s/<MT>/${model_type}/g" $new_vars_file
      sed -i "" "s/<RUN>/${r}/g" $new_vars_file
      sed -i "" "s/<N>/${noise}/g" $new_vars_file
      sed -i "" "s/<IMAGE>/${image}/g" $new_vars_file
    done
done

st='bald'
sa='random'
model_type='fcgn'
for r in $runs
do
  new_vars_file=env_var_files/${st}-${sa}-${model_type}-${r}.sh
  cp env_vars_template.sh $new_vars_file
  sed -i "" "s/<ST>/${st}/g" $new_vars_file
  sed -i "" "s/<SA>/${sa}/g" $new_vars_file
  sed -i "" "s/<MT>/${model_type}/g" $new_vars_file
  sed -i "" "s/<RUN>/${r}/g" $new_vars_file
  sed -i "" "s/<N>/${noise}/g" $new_vars_file
  sed -i "" "s/<IMAGE>/${image}/g" $new_vars_file
done

st='random'
sa='random'
model_type='fcgn'
for r in $runs
do
  new_vars_file=env_var_files/${st}-${sa}-${model_type}-${r}.sh
  cp env_vars_template.sh $new_vars_file
  sed -i "" "s/<ST>/${st}/g" $new_vars_file
  sed -i "" "s/<SA>/${sa}/g" $new_vars_file
  sed -i "" "s/<MT>/${model_type}/g" $new_vars_file
  sed -i "" "s/<RUN>/${r}/g" $new_vars_file
  sed -i "" "s/<N>/${noise}/g" $new_vars_file
  sed -i "" "s/<IMAGE>/${image}/g" $new_vars_file
done

# architecture comparison
strategy='subtower'
sampler='sequential'
model_types='fcgn-fc fcgn lstm'
for mt in $model_types
do
  for r in $runs
  do
    new_vars_file=env_var_files/${strategy}-${sampler}-${mt}-${r}.sh
    cp env_vars_template.sh $new_vars_file
    sed -i "" "s/<ST>/${strategy}/g" $new_vars_file
    sed -i "" "s/<SA>/${sampler}/g" $new_vars_file
    sed -i "" "s/<MT>/${mt}/g" $new_vars_file
    sed -i "" "s/<RUN>/${r}/g" $new_vars_file
    sed -i "" "s/<N>/${noise}/g" $new_vars_file
    sed -i "" "s/<IMAGE>/${image}/g" $new_vars_file
  done
done