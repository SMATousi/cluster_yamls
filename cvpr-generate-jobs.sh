#!/bin/bash

# vary the joints
# seed_start=1
# seed_end=5
# seed_variation=1

datasets=(
        # 'arts-and-crafts'
        'astronaut'
        'block-tower'
        'dance'
        'emergency-service'
        'gourmet-tuna'
        'hair-coloring'
        # 'hand-pointing'
        # 'healthy-dish'
        # 'home-fragrance'
        # 'in-ear-headphones'
        # 'pie-chart'
        # 'single-sneaker-on-white-background'
        # 'stop-sign'
        )




splits=(
        'train' 
        # 'val'
        'test'
        )

models=(
        'llava:7b' 
        'llava:13b' 
        'llava:34b' 
        'llava-llama3' 
        'bakllava' 
        # 'minicpm-v' 
        'llava-phi3'
        'llama3.2-vision:11b'
        'moondream'
        )

# Create jobs for each value in the range of seeds, model sizes, and methods

for split in "${splits[@]}"; do
  for model in "${models[@]}"; do
      for dataset in "${datasets[@]}"; do

        export split="$split"
        export model="$model"
        export dataset_name="$dataset"

        # Convert model name to lowercase and replace all invalid characters with '-'
        job_name=$(echo "$model" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]/-/g')

        # Remove any leading or trailing dashes (ensures valid RFC 1123 name)
        job_name=$(echo "$job_name" | sed 's/^-*//;s/-*$//')

        export job_name

        # Use environment variables in your job template and apply it
        envsubst < cvpr_vlm_agile.yaml | kubectl apply -f -

      done
  done
done

