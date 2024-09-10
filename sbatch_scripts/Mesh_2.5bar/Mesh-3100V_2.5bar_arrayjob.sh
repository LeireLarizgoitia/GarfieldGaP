#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-3100" #Vcathode_3000V

mkdir Vcathode-3100V
cd Vcathode-3100V
cp ../Mesh-3100V_2.5bar.sh .

sbatch --array=1-5 Mesh-3100V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
