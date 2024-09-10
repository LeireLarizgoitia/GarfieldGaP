#!/bin/bash

PRESSURE="4.5" #Mesh_1.5bar
EMODE="-13000" #Vcathode_3000V

mkdir Vcathode-13000V
cd Vcathode-13000V
cp ../Mesh-13000V_4.5bar.sh .

sbatch --array=1-5 Mesh-13000V_4.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
