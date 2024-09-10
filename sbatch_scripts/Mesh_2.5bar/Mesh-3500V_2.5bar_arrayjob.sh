#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-3500" #Vcathode_3000V

mkdir Vcathode-3500V
cd Vcathode-3500V
cp ../Mesh-3500V_2.5bar.sh .

sbatch --array=1-5 Mesh-3500V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
