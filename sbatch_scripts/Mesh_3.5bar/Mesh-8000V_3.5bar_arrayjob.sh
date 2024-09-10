#!/bin/bash

PRESSURE="3.5" #Mesh_1.5bar
EMODE="-8000" #Vcathode_3000V

mkdir Vcathode-8000V
cd Vcathode-8000V
cp ../Mesh-8000V_3.5bar.sh .

sbatch --array=1-5 Mesh-8000V_3.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
