#!/bin/bash
#SBATCH -J createFolder # A single job name for the array
#SBATCH --nodes=1
#SBATCH --mem 24000 # Memory request (in MB)
#SBATCH -t 00-24:00:00 # Maximum execution time (DD-HH:MM:00)
#SBATCH -o arrayjob.out # Standard output
#SBATCH -e arrayjob.err # Standard error | arrayjob_%A_%a.err : %A indicates job id

module load Python

python sbatch_createrunfiles_2ringFC.py
