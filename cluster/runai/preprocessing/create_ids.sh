output_dir="/project/outputs/ids/"

runai submit \
  --name oct-create-ids \
  --image aicregistry:5000/wds20:ldm_oct \
  --backoff-limit 0 \
  --gpu 0 \
  --cpu 4 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/generative_oct/:/project/ \
  --volume /nfs/home/wds20/datasets/KAGGLE_OCT/OCT2017/:/data/ \
  --command -- bash /project/src/bash/start_script.sh \
      python3 /project/src/python/preprocessing/create_ids.py \
          output_dir=${output_dir}
