#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-19000" #Vcathode_3000V

mkdir Vcathode-19000V
cd Vcathode-19000V
cp ../Mesh-19000V_2.5bar.sh .

sbatch --array=1-5 Mesh-19000V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
