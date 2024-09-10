#!/bin/bash

PRESSURE="1.5" #Mesh_1.5bar
EMODE="-18000" #Vcathode_3000V

mkdir Vcathode-18000V
cd Vcathode-18000V
cp ../Mesh-18000V_1.5bar.sh .

sbatch --array=1-5 Mesh-18000V_1.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
