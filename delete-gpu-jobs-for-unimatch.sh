#!/bin/bash

# vary the joints
# seed_start=1
# seed_end=5
# seed_variation=1

# # Create jobs for each value in the range of neurons, layers, and scale
# for (( seed=seed_start; seed<=seed_end; seed+=seed_variation )); do
#   # export seed="$seed"

#   # envsubst < unimatch_job.yaml | kubectl apply -f -
#   kubectl delete job ali-job-unimatch-base-${seed}
# done



seed_start=1
seed_end=5
seed_variation=1

model_size=('dino_small' 'dino_base' 'dino_large')

method=('unimatch_v2_wandb_wo_FA_normloss_gradient'
        'unimatch_v2_wandb_gradient' 
        'unimatch_v2_wandb_normloss_gradient' 
        'unimatch_v2_wandb_normloss' 
        'unimatch_v2_wandb_wo_FA_gradient' 
        'unimatch_v2_wandb_wo_FA_normloss' 
        'unimatch_v2_wandb_wo_FA' 
        'unimatch_v2_wandb'
        )

# Create jobs for each value in the range of seeds, model sizes, and methods
for size in "${model_size[@]}"; do
  for meth in "${method[@]}"; do
    for (( seed=seed_start; seed<=seed_end; seed+=seed_variation )); do
      # export seed="$seed"
      # export size="$size"
      # export meth="$meth"
      job_name="${meth//_/-}-${size//_/-}-${seed}"  # Only replace underscores in the method part of the job_name
      job_name="${job_name,,}"
      # Use environment variables in your job template and apply it
      # envsubst < unimatch_job.yaml | kubectl apply -f -
      kubectl delete job $job_name
    done
  done
done 