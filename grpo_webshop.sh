#!/bin/bash
#SBATCH --job-name=webshop-grpo            # shown by squeue / sacct
#SBATCH -o ./runs/output_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e ./runs/errors_%j.err  # File to which STDERR will be written, %j inserts jobid
#SBATCH --partition=gpu                     # change if your cluster has multiple GPU queues
#SBATCH --time=8:00:00                     # wall-clock limit (hh:mm:ss)
#SBATCH --nodes=1
#SBATCH --ntasks=1                          # one task per node (Ray will multithread)
#SBATCH --gpus-per-node=4                   # matches tensor_model_parallel_size=2
#SBATCH --constraint='a100|h100' # accept either model
#SBATCH --cpus-per-task=32                  # plenty for dataloader & Ray
#SBATCH --mem=0                             # “0” = give the full node memory
#SBATCH --account=lafferty     # if your site uses accounts
#SBATCH --mail-type=BEGIN,END,FAIL                # email on finish or error
#SBATCH --mail-user=alice.ding@yale.edu

# ============ USER SETUP SECTION ============
source ~/.bashrc
conda activate verl-agent-webshop

# ============ RUN TRAINING ============

# Any extra overrides can be appended after "$@".
bash examples/grpo_trainer/run_webshop.sh "$@"