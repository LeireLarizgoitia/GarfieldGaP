#!/bin/bash

PRESSURE="3.5" #Mesh_1.5bar
EMODE="-11000" #Vcathode_3000V

mkdir Vcathode-11000V
cd Vcathode-11000V
cp ../Mesh-11000V_3.5bar.sh .

sbatch --array=1-5 Mesh-11000V_3.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
