#!/bin/bash

PRESSURE="5.5" #Mesh_1.5bar
EMODE="-12000" #Vcathode_3000V

mkdir Vcathode-12000V
cd Vcathode-12000V
cp ../Mesh-12000V_5.5bar.sh .

sbatch --array=1-5 Mesh-12000V_5.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
