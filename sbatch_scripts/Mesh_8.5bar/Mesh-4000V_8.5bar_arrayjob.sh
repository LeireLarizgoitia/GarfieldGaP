#!/bin/bash

PRESSURE="8.5" #Mesh_1.5bar
EMODE="-4000" #Vcathode_3000V

mkdir Vcathode-4000V
cd Vcathode-4000V
cp ../Mesh-4000V_8.5bar.sh .

sbatch --array=1-5 Mesh-4000V_8.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
