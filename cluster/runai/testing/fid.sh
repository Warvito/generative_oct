seed=42
sample_dir="/project/outputs/samples_unconditioned/"
test_ids="/project/outputs/ids/validation.tsv"
num_workers=8
batch_size=16

runai submit \
  --name oct-fid \
  --image aicregistry:5000/wds20:ldm_oct \
  --backoff-limit 0 \
  --gpu 1 \
  --cpu 4 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/generative_oct/:/project/ \
  --volume /nfs/home/wds20/datasets/KAGGLE_OCT/OCT2017:/data/ \
  --command -- bash /project/src/bash/start_script.sh \
    python3 /project/src/python/testing/compute_fid.py \
      seed=${seed} \
      sample_dir=${sample_dir} \
      test_ids=${test_ids} \
      batch_size=${batch_size} \
      num_workers=${num_workers}
