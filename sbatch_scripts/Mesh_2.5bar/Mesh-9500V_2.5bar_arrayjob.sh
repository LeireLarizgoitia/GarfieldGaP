#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-9500" #Vcathode_3000V

mkdir Vcathode-9500V
cd Vcathode-9500V
cp ../Mesh-9500V_2.5bar.sh .

sbatch --array=1-5 Mesh-9500V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
