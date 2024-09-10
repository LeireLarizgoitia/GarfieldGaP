#!/bin/bash

PRESSURE="1.5" #Mesh_1.5bar
EMODE="-15000" #Vcathode_3000V

mkdir Vcathode-15000V
cd Vcathode-15000V
cp ../Mesh-15000V_1.5bar.sh .

sbatch --array=1-5 Mesh-15000V_1.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
