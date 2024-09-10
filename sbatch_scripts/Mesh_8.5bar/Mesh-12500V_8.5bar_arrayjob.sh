#!/bin/bash

PRESSURE="8.5" #Mesh_1.5bar
EMODE="-12500" #Vcathode_3000V

mkdir Vcathode-12500V
cd Vcathode-12500V
cp ../Mesh-12500V_8.5bar.sh .

sbatch --array=1-5 Mesh-12500V_8.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
