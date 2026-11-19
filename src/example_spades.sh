#!/bin/bash -l
#SBATCH --job-name spades
#SBATCH --output 00_LOGS/spades_%j.out
#SBATCH --error 00_LOGS/spades_%j.err
#SBATCH --time 16:00:00
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 12
#SBATCH --mem 400G
#SBATCH --account project_2022405

mkdir -p 00_LOGS

module load bio-apps
module load spades/4.3.0

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_THREAD_LIMIT=${SLURM_CPUS_PER_TASK}

spades.py \
        -1 01_DATA/DF16_1.fastq.gz \
        -2 01_DATA/DF16_2.fastq.gz \
        --threads ${SLURM_CPUS_PER_TASK} \
        --meta \
        --only-assembler \
        --memory 400 \
        --tmp-dir $TMPDIR \
        -o 02_ASSEMBLY 
