#!/bin/bash

PRESSURE="4.5" #Mesh_1.5bar
EMODE="-17500" #Vcathode_3000V

mkdir Vcathode-17500V
cd Vcathode-17500V
cp ../Mesh-17500V_4.5bar.sh .

sbatch --array=1-5 Mesh-17500V_4.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
