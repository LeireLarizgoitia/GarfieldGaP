#!/bin/bash

PRESSURE="5.5" #Mesh_1.5bar
EMODE="-10500" #Vcathode_3000V

mkdir Vcathode-10500V
cd Vcathode-10500V
cp ../Mesh-10500V_5.5bar.sh .

sbatch --array=1-5 Mesh-10500V_5.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
