#!/bin/bash

PRESSURE="4.5" #Mesh_1.5bar
EMODE="-3000" #Vcathode_3000V

mkdir Vcathode-3000V
cd Vcathode-3000V
cp ../Mesh-3000V_4.5bar.sh .

sbatch --array=1-5 Mesh-3000V_4.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
