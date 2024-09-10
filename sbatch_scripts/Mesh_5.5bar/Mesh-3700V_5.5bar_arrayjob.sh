#!/bin/bash

PRESSURE="5.5" #Mesh_1.5bar
EMODE="-3700" #Vcathode_3000V

mkdir Vcathode-3700V
cd Vcathode-3700V
cp ../Mesh-3700V_5.5bar.sh .

sbatch --array=1-5 Mesh-3700V_5.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
