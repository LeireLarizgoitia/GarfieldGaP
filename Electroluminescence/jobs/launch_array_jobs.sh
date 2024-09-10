#!/bin/bash

PRESSURE="$1" #Mesh_1.5bar
EMODE="$2" #Vcathode_3000V

mkdir Vcathode$2V
cd Vcathode$2V
cp ../Mesh$2V_$1bar.sh .

sbatch --array=1-5 Mesh$2V_$1bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
