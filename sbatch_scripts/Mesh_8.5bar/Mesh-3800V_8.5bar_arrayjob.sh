#!/bin/bash

PRESSURE="8.5" #Mesh_1.5bar
EMODE="-3800" #Vcathode_3000V

mkdir Vcathode-3800V
cd Vcathode-3800V
cp ../Mesh-3800V_8.5bar.sh .

sbatch --array=1-5 Mesh-3800V_8.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
