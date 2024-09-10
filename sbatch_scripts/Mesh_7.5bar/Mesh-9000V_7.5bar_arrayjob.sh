#!/bin/bash

PRESSURE="7.5" #Mesh_1.5bar
EMODE="-9000" #Vcathode_3000V

mkdir Vcathode-9000V
cd Vcathode-9000V
cp ../Mesh-9000V_7.5bar.sh .

sbatch --array=1-5 Mesh-9000V_7.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
