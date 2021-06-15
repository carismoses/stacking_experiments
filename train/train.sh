# configure minio
./mc config host add honda_cmm $CSAIL_ENDPOINT $HONDA_ACCESS $HONDA_SECRET

# clone stacking repo
git clone --single-branch --branch phaedra https://github.com/Learning-and-Intelligent-Systems/stacking.git

# link other packages
cd stacking
ln -s /pb_robot/src/pb_robot .
ln -s /pddlstream/pddlstream .

# so can run on phaedra
pip3 install torch==1.2.0 torchvision==0.4.0

# run training code
python3.7 -m learning.experiments.active_train_towers \
                --block-set-fname learning/domains/towers/train_sim_block_set_10.pkl \
                --exp-name ${EXP} \
                --sampler ${SAMPLER} \
                --strategy ${STRATEGY} \
                --model ${MODEL} \
                --exec-mode noisy-model \
                --max-acquisitions 100 \
                --n-samples 100000 \
                --n-epochs 20 \
                --n-models 10 \
                --xy-noise 0.001

# copy over results to minio
/./mc cp -r learning/experiments/logs/ honda_cmm/stacking/rss_camera_ready/
