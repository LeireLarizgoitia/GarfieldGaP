#!/bin/bash
#SBATCH -J Mesh # A single job name for the array
#SBATCH --nodes=1
#SBATCH --mem 24000 # Memory request (in MB)
#SBATCH -t 00-24:00:00 # Maximum execution time (DD-HH:MM:00)
#SBATCH -o Mesh_job_%A_%a.out # Standard output
#SBATCH -e Mesh_job_%A_%a.err # Standard error

start=`date +%s`

#SLURM_ARRAY_TASK_ID=1

# Set the configurable variables
JOBNAME="Mesh-7500V_4.5bar" #"Mesh"
PRESSURE=4.5 #bar
GASFILE="/scratch/llarizgoitia/GarfieldGaP/Electroluminescence/gases/ar_4.5bar" # gas file
MPHFILE="/scratch/llarizgoitia/GarfieldGaP/ComsolData/mesh_GaP3D_photoedge" #"mesh GaP3D"
DATAFILE="/scratch/llarizgoitia/GarfieldGaP/ComsolData/ELscan/electricpotential-7500V" #"electricpotential GaP3D"
MATFILE="/scratch/llarizgoitia/GarfieldGaP/ComsolData/material_GaP3D" #"material GaP3D"
N_EVENTS=2000 #1

# Create the directory
cd /scratch/llarizgoitia/GarfieldGaP/sbatch_scripts/job_output/
mkdir -p $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"
cd $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"

# Setup nexus and run
echo "Setting Up Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

# Load Garfield module that includes source to cmake
ml load Garfield++/5.0

# Calculate the unique seed number
SEED=$(${N_EVENTS}*(${SLURM_ARRAY_TASK_ID} - 1)) #$((${N_EVENTS}*(${SLURM_ARRAY_TASK_ID} - 1) + ${N_EVENTS}))
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
let seconds=deltatime%60
let MM=deltatime/60 # Total number of minutes
let minutes=${MM}%60
let hours=${MM}/60
printf "Time spent: %d:%02d:%02d\n" $hours $minutes $seconds | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

cd /scratch/llarizgoitia/GarfieldGaP/sbatch_scripts
