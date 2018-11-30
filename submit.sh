#!/usr/bin/bash
#SBATCH --job-name=tSweep
#SBATCH --ntasks=1
#SBATCH --get-user-env
#SBATCH --time=24:00:00
#SBATCH --mem=8000
#SBATCH --err=log/error.txt
#SBATCH --out=log/output.txt
#SBATCH --array=5-40

DATAFILE=$1
SAVEDIR=$2

srun Rscript src/run_tsne.R $DATAFILE $SLURM_ARRAY_TASK_ID $SAVEDIR
wait
srun Rscript src/facet_plot.R $SAVEDIR
