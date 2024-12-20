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
JOBNAME="$1" #"Mesh"
PRESSURE=$2 #10.0
GASFILE="$3" # gas file
MPHFILE="$4" #"mesh GaP3D"
DATAFILE="$5" #"electricpotential GaP3D"
MATFILE="$6" #"material GaP3D"
N_EVENTS=$7 #1

# Create the directory
cd /Users/llarizgoitialive/Library/CloudStorage/OneDrive-Personal/GanESS/GarfieldCode/GarfieldGap/scripts/job_output/
mkdir -p Mesh_${PRESSURE}bar
cd Mesh_${PRESSURE}bar
mkdir -p $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"
cd $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"

# Setup nexus and run
echo "Setting Up Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

source /Users/llarizgoitialive/Garfield/install/share/Garfield/setupGarfield.zsh

# Calculate the unique seed number
SEED=$((${N_EVENTS}*(${SLURM_ARRAY_TASK_ID} - 1) + ${N_EVENTS}))
echo "The seed number is: ${SEED}" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

# NEXUS
echo "Running Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt
# evt id, num e-, seed, grid, jobid, pressure , gridfile datafile materialfile
cmake /Users/llarizgoitialive/Library/CloudStorage/OneDrive-Personal/GanESS/GarfieldCode/GarfieldGap/Electroluminescence
make
#./Mesh_noPrint ${SEED} ${N_EVENTS} ${SEED} 1 ${SLURM_ARRAY_TASK_ID} ${PRESSURE} ${MPHFILE} ${DATAFILE} ${MATFILE}
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

cd /Users/llarizgoitialive/Library/CloudStorage/OneDrive-Personal/GanESS/GarfieldCode/GarfieldGap/scripts
