seed=42
sample_dir="/project/outputs/samples_unconditioned/"
num_workers=8

runai submit \
  --name mammo-ssim-sample \
  --image aicregistry:5000/wds20:ldm_mammography \
  --backoff-limit 0 \
  --gpu 1 \
  --cpu 4 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/generative_mammography/:/project/ \
  --command -- bash /project/src/bash/start_script.sh \
    python3 /project/src/python/testing/compute_msssim_sample.py \
      seed=${seed} \
      sample_dir=${sample_dir} \
      num_workers=${num_workers}

seed=42
test_ids="/project/outputs/ids/test.tsv"
num_workers=8

runai submit \
  --name mammo-ssim-test-set \
  --image aicregistry:5000/wds20:ldm_mammography \
  --backoff-limit 0 \
  --gpu 1 \
  --cpu 8 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/generative_mammography/:/project/ \
  --volume /nfs/home/wds20/datasets/CSAW/sourcedata/:/data/ \
  --command -- bash /project/src/bash/start_script.sh \
    python3 /project/src/python/testing/compute_msssim_sample.py \
      seed=${seed} \
      sample_dir=${sample_dir} \
      num_workers=${num_workers}
