#!/bin/bash

PRESSURE="7.5" #Mesh_1.5bar
EMODE="-14500" #Vcathode_3000V

mkdir Vcathode-14500V
cd Vcathode-14500V
cp ../Mesh-14500V_7.5bar.sh .

sbatch --array=1-5 Mesh-14500V_7.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
