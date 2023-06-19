metadata_path="/sourcedata/labels/CSAW-M_train.csv"
output_dir="/project/outputs/ids/"

runai submit \
  --name create-ids-mammo \
  --image aicregistry:5000/wds20:ldm_mammography \
  --backoff-limit 0 \
  --gpu 0 \
  --cpu 4 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/datasets/CSAW/sourcedata/:/sourcedata/ \
  --volume /nfs/home/wds20/projects/generative_mammography/:/project/ \
  --command -- python /project/src/python/preprocessing/create_ids.py \
    --metadata_path=${metadata_path} \
    --output_dir=${output_dir}
