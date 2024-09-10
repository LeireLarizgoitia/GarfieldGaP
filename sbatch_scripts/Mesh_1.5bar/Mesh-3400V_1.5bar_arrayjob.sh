#!/bin/bash

PRESSURE="1.5" #Mesh_1.5bar
EMODE="-3400" #Vcathode_3000V

mkdir Vcathode-3400V
cd Vcathode-3400V
cp ../Mesh-3400V_1.5bar.sh .

sbatch --array=1-5 Mesh-3400V_1.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
