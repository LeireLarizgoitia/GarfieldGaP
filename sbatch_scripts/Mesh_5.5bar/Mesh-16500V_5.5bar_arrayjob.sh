#!/bin/bash

PRESSURE="5.5" #Mesh_1.5bar
EMODE="-16500" #Vcathode_3000V

mkdir Vcathode-16500V
cd Vcathode-16500V
cp ../Mesh-16500V_5.5bar.sh .

sbatch --array=1-5 Mesh-16500V_5.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
