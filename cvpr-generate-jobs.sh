#!/bin/bash

# vary the joints
# seed_start=1
# seed_end=5
# seed_variation=1

splits=('train' 'test')

models=('llava:7b' 
        'llava:13b' 
        'llava:34b' 
        'llava-llama3' 
        'bakllava' 
        'minicpm-v' 
        'llava-phi3'
        'llama3.2-vision:11b'
        #'moondream'
        )

# Create jobs for each value in the range of seeds, model sizes, and methods
for split in "${splits[@]}"; do
  for model in "${models[@]}"; do

      export split="$split"
      export model="$model"

      # Convert model name to lowercase and replace all invalid characters with '-'
      job_name=$(echo "$model" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]/-/g')

      # Remove any leading or trailing dashes (ensures valid RFC 1123 name)
      job_name=$(echo "$job_name" | sed 's/^-*//;s/-*$//')

      export job_name

      # Use environment variables in your job template and apply it
      envsubst < cvpr_vlm_job.yaml | kubectl apply -f -
  done
done