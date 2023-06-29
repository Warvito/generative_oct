stage1_mlflow_path="/project/mlruns/721721503681535766/2a05fc762c734a8f9914cfe46968250e/artifacts/final_model"
diffusion_mlflow_path="/project/mlruns/907752362848865924/1b34bd92192c48af90846dc6b323f7d3/artifacts/final_model"
output_dir="/project/outputs/trained_models/"

runai submit \
  --name oct-convert-model \
  --image aicregistry:5000/wds20:ldm_oct \
  --backoff-limit 0 \
  --gpu 1 \
  --cpu 4 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/generative_oct/:/project/ \
  --command -- bash /project/src/bash/start_script.sh \
    python3 /project/src/python/testing/convert_mlflow_to_pytorch.py \
      stage1_mlflow_path=${stage1_mlflow_path} \
      diffusion_mlflow_path=${diffusion_mlflow_path} \
      output_dir=${output_dir}
