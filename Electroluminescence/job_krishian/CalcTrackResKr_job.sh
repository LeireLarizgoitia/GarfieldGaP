#!/bin/bash
#SBATCH -J Trackres # A single job name for the array
#SBATCH --nodes=1
#SBATCH --mem 4000 # Memory request (6Gb)
#SBATCH -t 0-12:00 # Maximum execution time (D-HH:MM)
#SBATCH -o Trackres_%A_%a.out # Standard output
#SBATCH -e Trackres_%A_%a.err # Standard error

echo "Initialising NEXUS environment" 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt
start=`date +%s`

# Set the configurable variables
JOBNAME="TrackResKr"
Mode="Aligned"
Option="Kr"
FILES_PER_JOB=1
N_EVENTS=10000
CONFIG=NEW.eminus_40keV.config.mac
INIT=NEW.eminus_40keV.init.mac

# Create the directory
cd /media/argon/HDD_8tb/
mkdir -p $JOBNAME/$Mode/jobid_"${SLURM_ARRAY_TASK_ID}"
cd $JOBNAME/$Mode/jobid_"${SLURM_ARRAY_TASK_ID}"

# Copy the files over
cp /home/argon/Projects/Krishan/GarfieldCode/Electroluminescence/config/${CONFIG} .
cp /home/argon/Projects/Krishan/GarfieldCode/Electroluminescence/config/${INIT} .
cp /home/argon/Projects/Krishan/GarfieldCode/Electroluminescence/CalcTrackRes.py .
cp /home/argon/Projects/Krishan/GarfieldCode/Electroluminescence/Maps/*.h5 .

# Setup nexus and run
echo "Setting Up NEXUS and IC" 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt
source /home/argon/Projects/Krishan/nexus/setup_cluster.sh
source /home/argon/Software/IC/setup_IC.sh

for i in $(eval echo "{1..${FILES_PER_JOB}}"); do

    # Replace the seed in the file	
    SEED=$((${N_EVENTS}*${FILES_PER_JOB}*(${SLURM_ARRAY_TASK_ID} - 1) + ${N_EVENTS}*${i}))
    echo "The seed number is: ${SEED}" 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt
    sed -i "s#.*random_seed.*#/nexus/random_seed ${SEED}#" ${CONFIG}
    sed -i "s#.*start_id.*#/nexus/persistency/start_id ${SEED}#" ${CONFIG}

    # NEXUS
    echo "Running NEXUS" 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt
    nexus -n $N_EVENTS ${INIT} 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt

    # Now run the Track resolution script
    python CalcTrackRes.py $Mode $Option| tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt

    echo; echo; echo;
done

# Cleaning up

# Remove the config files if not the first jobid
if [ ${SLURM_ARRAY_TASK_ID} -ne 1 ]; then
    rm -v *.mac 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt
    rm -v NEW.eminus.next | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt
fi

echo "FINISHED....EXITING" 2>&1 | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt

end=`date +%s`
let deltatime=end-start
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60
printf "Time spent: %d:%02d:%02d\n" $hours $minutes $seconds | tee -a log_nexus_"${SLURM_ARRAY_TASK_ID}".txt