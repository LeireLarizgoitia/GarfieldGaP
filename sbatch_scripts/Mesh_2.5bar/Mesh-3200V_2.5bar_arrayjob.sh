#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-3200" #Vcathode_3000V

mkdir Vcathode-3200V
cd Vcathode-3200V
cp ../Mesh-3200V_2.5bar.sh .

sbatch --array=1-5 Mesh-3200V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
