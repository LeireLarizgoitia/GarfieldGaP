# GarfieldGaP
GaP mesh study

- Make sure Garfield is up to date
(the code is still frequently modified. To obtain the latest version, use the command git pull origin master and rebuild the project.
source_Garfield)
	-  git pull origin master
	-  act_root
	- rebuild the project

- RUN .sh script in mac terminal (example)
  source_root
  source Mesh-3000V_1.5bar.sh

COMSOL different 3D volumes defined:

1. ComsolData: Field Cage with only 2 ring. Operating conditions of GaP. USE THIS!
2. ComsolData_SolidPlateFullFC: full Field Cage, inefficient and drift voltaje incorrectly defined
3. ComsolData_noSolidPlateAroundMesh: simplest but not very real

---------------

GARFIELD code to generate Gas files : GasFile              

---------------
---------------

Electroluminescence : GARFIELD code

---------------

GasMedium: code is ready to choose the Gas medium type
NO GasMedium: gas set to Argon

Electroluminescence: Mesh_noPrint.C (Argon)
										 MeshGaP_GasMedium.C (choose gas medium)

Electroluminescence/jobs: Mesh_job_L.sh and Mesh_job_L_GasMedium.sh  : local run
													sbatchMesh2ringFC_job.sh (Argon) and sbatchMesh2ringFC_GasMedium_job.sh (choose gas medium) : atlas EDR run

---------------
CREATE SCRIPTS TO LAUNCH RUNS

script_python_createfiles.sh : run in cluster locally with SOURCE, runs this sbatch_createrunfiles_2ringFC.py

sbatch_createrunfiles_2ringFC.py (run in cluster locally with SOURCE): create all combinations of V-Gate and P in different scripts contained all in a folder (sbatch_scripts_2ringFC)
