#!/bin/bash -l
#SBATCH --job-name gtdbtk
#SBATCH --output 00_LOGS/gtdbtk_%j.out
#SBATCH --error 00_LOGS/gtdbtk_%j.err
#SBATCH --time 00:30:00
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 10
#SBATCH --mem 50G
#SBATCH --account project_2022405

module load  bio-apps/v202603
module load py-gtdbtk/2.7.2
mkdir -p HQ_BINS/GTDBTK

gtdbtk classify_wf \
    --genome_dir HQ_BINS \
    --out_dir HQ_BINS/GTDBTK \
    --extension fa \
    --cpus "$SLURM_CPUS_PER_TASK" \
    --pplacer_cpus 1 \
    --tmpdir "$TMPDIR"
