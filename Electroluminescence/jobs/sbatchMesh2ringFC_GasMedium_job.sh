#!/bin/bash
#SBATCH -J Mesh_2ringFC # A single job name for the array
#SBATCH --nodes=1
#SBATCH --mem 48000 # Memory request (in MB)
#SBATCH -t 00-24:00:00 # Maximum execution time (DD-HH:MM:00)
#SBATCH -o arrayjob_%a.out # Standard output
#SBATCH -e arrayjob_%a.err # Standard error | arrayjob_%A_%a.err : %A indicates job id
#SBATCH --array=1-10       # instance indexes

start=`date +%s`

#SLURM_ARRAY_TASK_ID=1

# Set the configurable variables
JOBNAME="$1" #"Mesh"
PRESSURE=$2 #bar
GASFILE="$3" # gas file
MPHFILE="$4" #"mesh GaP3D"
DATAFILE="$5" #"electricpotential GaP3D"
MATFILE="$6" #"material GaP3D"
N_EVENTS=$7 #1
GASNAME="$8" # "ar" or "xe"

# Create the directory
cd /scratch/llarizgoitia/GarfieldGaP/
mkdir -p sbatch_scripts_2ringFC_${GASNAME}
cd sbatch_scripts_2ringFC_${GASNAME}/

mkdir -p job_output_2ringFC_${GASNAME}/
cd job_output_2ringFC_${GASNAME}/

mkdir -p Mesh_${PRESSURE}bar
cd Mesh_${PRESSURE}bar

mkdir -p $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"
cd $JOBNAME/jobid_"${SLURM_ARRAY_TASK_ID}"

# Setup nexus and run
echo "Setting Up Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

# Load Garfield module that includes source to cmake
ml load Garfield++/5.0

# Calculate the unique seed number
SEED=$((${N_EVENTS}*(${SLURM_ARRAY_TASK_ID} - 1) + ${N_EVENTS}))
echo "The seed number is: ${SEED}" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

# NEXUS
echo "Running Garfield" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt
# evt id, num e-, seed, grid, jobid, pressure , gridfile datafile materialfile
cmake /scratch/llarizgoitia/GarfieldGaP/Electroluminescence
make
#./Mesh_noPrint ${SEED} ${N_EVENTS} ${SEED} 1 ${SLURM_ARRAY_TASK_ID} ${PRESSURE} ${GASFILE} ${MPHFILE} ${DATAFILE} ${MATFILE}
./MeshGaP_GasMedium ${SEED} ${N_EVENTS} ${SEED} ${SLURM_ARRAY_TASK_ID} ${MPHFILE} ${DATAFILE} ${MATFILE} ${PRESSURE} ${GASNAME} ${GASFILE}

echo; echo; echo;

echo "FINISHED....EXITING" 2>&1 | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt

end=`date +%s`
let deltatime=end-start
let seconds=deltatime%60
let MM=deltatime/60 # Total number of minutes
let minutes=${MM}%60
let hours=${MM}/60
printf "Time spent: %d:%02d:%02d\n" $hours $minutes $seconds | tee -a log_run_"${SLURM_ARRAY_TASK_ID}".txt
