#!/bin/bash

PRESSURE="6.5" #Mesh_1.5bar
EMODE="-16000" #Vcathode_3000V

mkdir Vcathode-16000V
cd Vcathode-16000V
cp ../Mesh-16000V_6.5bar.sh .

sbatch --array=1-5 Mesh-16000V_6.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
