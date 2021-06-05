# configure minio
./mc config host add honda_cmm $CSAIL_ENDPOINT $HONDA_ACCESS $HONDA_SECRET

# clone stacking repo
git clone https://github.com/Learning-and-Intelligent-Systems/stacking.git

# link other packages
cd stacking
ln -s /pb_robot/src/pb_robot .
ln -s /pddlstream/pddlstream .

# copy exp path into stacking
/./mc cp -r honda_cmm/stacking/rss_camera_ready/${EXP}/ ${EXP}

# run evaluation code
python3.7 -m learning.evaluate.plan_evaluate_models \
                    --block-set-fname learning/domains/towers/eval_sim_block_set_10.pkl \
                    --problem ${PROBLEM} \
                    --exp-path ${EXP} \
                    --max-acquisitions 100 \
                    --n-towers 50 \
                    --tower-sizes ${NBLOCKS} \
                    --planning-model learned \
                    --exec-mode simple-model \
                    --exec-xy-noise 0.000

# copy over results to minio
/./mc cp -r ${EXP}/figures honda_cmm/stacking/rss_camera_ready/${EXP}