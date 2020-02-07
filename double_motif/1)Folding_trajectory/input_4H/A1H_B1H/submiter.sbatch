#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 8192
#SBATCH --time 16:00:00
#SBATCH --array=1-200
#SBATCH --output=/scratch/cheyang/logs/output.%A_%a.out
#SBATCH --error=/scratch/cheyang/logs/output.%A_%a.err

mkdir -p out
pass_=1
if [ ${SLURM_ARRAY_TASK_ID} -eq $pass_ ]; then
    srun /work/upcorreia/bin/devel/Rosetta/main/source/bin/fold_from_loops.linuxgccrelease @build.commands -in:file:vall /work/upcorreia/databases/vall.2011.07/vall.jul19.2011.gz -out:file:frag_prefix frag_${SLURM_ARRAY_TASK_ID} -out:prefix twoMoitf_A1H_B1H_${SLURM_ARRAY_TASK_ID} -out:file:silent out/twoMoitf_A1H_B1H_${SLURM_ARRAY_TASK_ID}
else
    while [ ! -e frag_1.200.3mers ]; do
        sleep 2m
    done
    sleep 25s
    srun /work/upcorreia/bin/devel/Rosetta/main/source/bin/fold_from_loops.linuxgccrelease @build.commands -in:file:frag3 frag_1.200.3mers -in:file:frag9 frag_1.200.9mers -out:prefix twoMoitf_A1H_B1H_${SLURM_ARRAY_TASK_ID} -out:file:silent out/twoMoitf_A1H_B1H_${SLURM_ARRAY_TASK_ID}
fi
echo "CASTOR: RUN FINISHED"
