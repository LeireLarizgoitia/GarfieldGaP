#!/bin/bash

PRESSURE="7.5" #Mesh_1.5bar
EMODE="-8500" #Vcathode_3000V

mkdir Vcathode-8500V
cd Vcathode-8500V
cp ../Mesh-8500V_7.5bar.sh .

sbatch --array=1-5 Mesh-8500V_7.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
