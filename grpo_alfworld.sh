#!/bin/bash
#SBATCH --job-name=alfworld-grpo            # shown by squeue / sacct
#SBATCH --output=%x_%j.log                  # stdout+stderr -> alfworld-grpo_<jobid>.log
#SBATCH --partition=gpu                     # change if your cluster has multiple GPU queues
#SBATCH --time=12:00:00                     # wall-clock limit (hh:mm:ss)
#SBATCH --nodes=1
#SBATCH --ntasks=1                          # one task per node (Ray will multithread)
#SBATCH --gpus-per-node=4                   # matches tensor_model_parallel_size=2
#SBATCH --cpus-per-task=40                  # plenty for dataloader & Ray
#SBATCH --mem=0                             # “0” = give the full node memory
#SBATCH --account=lafferty     # if your site uses accounts
#SBATCH --mail-type=BEGIN,END,FAIL                # email on finish or error
#SBATCH --mail-user=alice.ding@yale.edu

# ============ USER SETUP SECTION ============
source ~/.bashrc
conda activate verl-agent

# ============ RUN TRAINING ============

# Any extra overrides can be appended after "$@".
bash examples/grpo_trainer/run_alfworld.sh "$@"