stage1_mlflow_path="/project/mlruns/528206275705240271/0453cddba39645df82bc7780541e6039/artifacts/final_model"
diffusion_mlflow_path="/project/mlruns/423684214116739438/9528560acc084fd49a0e0981aca6f747/artifacts/final_model"
output_dir="/project/outputs/trained_models/"

runai submit \
  --name mammo-convert-model \
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
    python3 /project/src/python/testing/convert_mlflow_to_pytorch.py \
      stage1_mlflow_path=${stage1_mlflow_path} \
      diffusion_mlflow_path=${diffusion_mlflow_path} \
      output_dir=${output_dir}
