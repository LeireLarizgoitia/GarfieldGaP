#!/bin/bash

PRESSURE="5.5" #Mesh_1.5bar
EMODE="-3600" #Vcathode_3000V

mkdir Vcathode-3600V
cd Vcathode-3600V
cp ../Mesh-3600V_5.5bar.sh .

sbatch --array=1-5 Mesh-3600V_5.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
