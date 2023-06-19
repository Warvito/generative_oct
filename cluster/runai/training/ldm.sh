seed=2
run_dir="aekl_v1_ldm_v1"
training_ids="/project/outputs/ids/train.tsv"
validation_ids="/project/outputs/ids/validation.tsv"
stage1_uri="/project/mlruns/528206275705240271/0453cddba39645df82bc7780541e6039/artifacts/final_model"
config_file="/project/configs/ldm/ldm_v1.yaml"
scale_factor=0.3
batch_size=48
n_epochs=1000
eval_freq=10
num_workers=64
experiment="LDM"

runai submit \
  --name mammo-ldm-v1 \
  --image aicregistry:5000/wds20:ldm_mammography \
  --backoff-limit 0 \
  --gpu 4 \
  --cpu 32 \
  --large-shm \
  --run-as-user \
  --node-type "A100" \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/generative_mammography/:/project/ \
  --volume /nfs/home/wds20/datasets/CSAW/sourcedata/:/data/ \
  --command -- bash /project/src/bash/start_script.sh \
      python3 /project/src/python/training/train_ldm.py \
      seed=${seed} \
      run_dir=${run_dir} \
      training_ids=${training_ids} \
      validation_ids=${validation_ids} \
      stage1_uri=${stage1_uri} \
      config_file=${config_file} \
      scale_factor=${scale_factor} \
      batch_size=${batch_size} \
      n_epochs=${n_epochs} \
      eval_freq=${eval_freq} \
      num_workers=${num_workers} \
      experiment=${experiment}
