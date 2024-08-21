#!/bin/bash
#SBATCH -J Mesh # A single job name for the array
#SBATCH --nodes=1
#SBATCH --mem 4000 # Memory request (6Gb)
#SBATCH -t 0-24:00 # Maximum execution time (D-HH:MM)
#SBATCH -o Mesh_%A_%a.out # Standard output
#SBATCH -e Mesh_%A_%a.err # Standard error

start=`date +%s`

SLURM_ARRAY_TASK_ID=1

# Set the configurable variables
JOBNAME="Mesh-8500V_8.5bar" #"Mesh"
PRESSURE=8.5 #10.0
GASFILE="/scratch/llarizgoitia/GarfieldGaP/Electroluminescence/gases/ar_8.5bar" # gas file
MPHFILE="/scratch/llarizgoitia/GarfieldGaP/ComsolData/mesh_GaP3D_photoedge" #"mesh GaP3D"
DATAFILE="/scratch/llarizgoitia/GarfieldGaP/ComsolData/ELscan/electricpotential-8500V" #"electricpotential GaP3D"
MATFILE="/scratch/llarizgoitia/GarfieldGaP/ComsolData/material_GaP3D" #"material GaP3D"
N_EVENTS=10000 #1

# Create the directory
cd /scratch/llarizgoitia/GarfieldGaP/sbatch_scripts/job_output/
mkdir -p $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"
cd $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"

# Setup nexus and run
echo "Setting Up Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

#source /Users/llarizgoitialive/Garfield/install/share/Garfield/setupGarfield.zsh
ml load Garfield++/5.0

# Calculate the unique seed number
SEED=$((${N_EVENTS}*(${SLURM_ARRAY_TASK_ID} - 1) + ${N_EVENTS}))
echo "The seed number is: ${SEED}" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

# NEXUS
echo "Running Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt
# evt id, num e-, seed, grid, jobid, pressure , gridfile datafile materialfile
cmake /scratch/llarizgoitia/GarfieldGaP/Electroluminescence
make
./Mesh_noPrint ${SEED} ${N_EVENTS} ${SEED} ${SLURM_ARRAY_TASK_ID} ${PRESSURE} ${GASFILE} ${MPHFILE} ${DATAFILE} ${MATFILE}

echo; echo; echo;

echo "FINISHED....EXITING" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

end=`date +%s`
let deltatime=end-start
echo deltatime
let hours=deltatime/3600
echo hours
let minutes=deltatime/60
echo minutes
let seconds=deltatime%60
echo seconds
printf "Time spent: %d:%02d:%02d\n" $hours $minutes $seconds | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

cd /scratch/llarizgoitia/GarfieldGaP/sbatch_scripts
