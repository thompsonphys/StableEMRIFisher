#!/bin/bash
#SBATCH -p gpu_a100_22c
#SBATCH -G a100:1
#SBATCH --mem=64G
#SBATCH -c 2
#SBATCH -e fm_%A.err
#SBATCH -o fm_%A.out
#SBATCH --job-name=fm
#SBATCH -t 24:00:00

# --- Validate input argument ---
if [[ -z "$1" ]]; then
  echo "Usage: sbatch submitFM.sh <number>"
  echo "Error: missing required numeric argument."
  exit 1
fi

# Ensure the argument is an integer (optional: allow floats if you prefer)
if ! [[ "$1" =~ ^-?[0-9]+$ ]]; then
  echo "Error: argument must be an integer (received: '$1')."
  exit 1
fi

CASE_NUMBER="$1"

echo "Running FM_case_1.py with CASE_NUMBER=${CASE_NUMBER}"
echo "SLURM Job ID: ${SLURM_JOB_ID}"

# Change to pipeline directory
cd /home/lisa_nlddpc-lsperi/GitHub/EMRI-FoM/local_installations/StableEMRIFisher/

# Run the pipeline with parameters using Singularity container
singularity exec --nv ../base python FM_case_1.py "$CASE_NUMBER"

echo "Job ended."
