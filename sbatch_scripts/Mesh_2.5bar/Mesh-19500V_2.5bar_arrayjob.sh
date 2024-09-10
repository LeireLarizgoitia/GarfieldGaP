#!/bin/bash

PRESSURE="2.5" #Mesh_1.5bar
EMODE="-19500" #Vcathode_3000V

mkdir Vcathode-19500V
cd Vcathode-19500V
cp ../Mesh-19500V_2.5bar.sh .

sbatch --array=1-5 Mesh-19500V_2.5bar.sh

#mkdir $ENAME
#cd $ENAME
#cp ../Mesh${EMODE}V_${PRESSURE}bar.sh .

#sbatch --array=1-5 Mesh${EMODE}V_${PRESSURE}bar.sh
