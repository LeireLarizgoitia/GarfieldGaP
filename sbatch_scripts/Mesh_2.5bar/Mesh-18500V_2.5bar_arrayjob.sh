#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-18500" #Vcathode_3000V

mkdir Vcathode-18500V
cd Vcathode-18500V
cp ../Mesh-18500V_2.5bar.sh .

sbatch --array=1-5 Mesh-18500V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
