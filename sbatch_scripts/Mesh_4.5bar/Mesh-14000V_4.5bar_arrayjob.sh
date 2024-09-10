#!/bin/bash

PRESSURE="4.5" #Mesh_1.5bar
EMODE="-14000" #Vcathode_3000V

mkdir Vcathode-14000V
cd Vcathode-14000V
cp ../Mesh-14000V_4.5bar.sh .

sbatch --array=1-5 Mesh-14000V_4.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
