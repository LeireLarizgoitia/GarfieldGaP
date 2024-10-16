import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os


"Y/p (photons electron**−1 cm**−1 bar**−1)= 81E/p − 47 : C.M.B. Monteiro et al. / Physics Letters B 668 (2008) 167–170"

pressure = np.arange(1.5,9.5,1.) #bar pressure
print(pressure)

vcathode_500drift = np.arange(-20000,-7000,500)
vcathode_100drift = np.arange(-4000,-2900,100)

path = "/scratch/llarizgoitia/GarfieldGaP/Electroluminescence/"

path_real = "/Users/llarizgoitialive/Library/CloudStorage/OneDrive-Personal/GanESS/GarfieldCode/GarfieldGaP/Electroluminescence/"
template = open(path_real+"jobs/sbatchMesh_job.sh", "rt").read()

path_data = "/scratch/llarizgoitia/GarfieldGaP/ComsolData/"

MPHFILE= path_data+"mesh_GaP3D_photoedge"
MATFILE= path_data+"material_GaP3D"
N_EVENTS = 2000 #10000

for j in range(0,len(pressure)):
    GASFILE = path+"gases/ar_"+str(pressure[j])+"bar"
    for i in range(0,len(vcathode_500drift)):
        DATAFILE = path_data+"ELscan/electricpotential"+str(vcathode_500drift[i])+"V"
        jobname = "Mesh"+str(vcathode_500drift[i])+"V_"+str(pressure[j])+"bar"
        pressure_folder = "Mesh_"+str(pressure[j])+"bar"
        scriptname = "sbatch_scripts/"+pressure_folder+"/"+jobname +".sh"
        print(scriptname)
        template_str_rep = template.replace("$1", jobname).replace("$2", str(pressure[j])).replace("$3", GASFILE).replace("$4", MPHFILE).replace("$5", DATAFILE).replace("$6", MATFILE).replace("$7", str(N_EVENTS))

        os.makedirs(os.path.dirname(scriptname), exist_ok=True)
        with open(scriptname, "wt") as output:
            output.write (template_str_rep)

    for i in range(0,len(vcathode_100drift)):
        DATAFILE = path_data+"ELscan/electricpotential"+str(vcathode_100drift[i])+"V"
        jobname = "Mesh"+str(vcathode_100drift[i])+"V_"+str(pressure[j])+"bar"
        scriptname = "sbatch_scripts/"+pressure_folder+"/"+jobname +".sh"
        print(scriptname)
        template_str_rep = template.replace("$1", jobname).replace("$2", str(pressure[j])).replace("$3", GASFILE).replace("$4", MPHFILE).replace("$5", DATAFILE).replace("$6", MATFILE).replace("$7", str(N_EVENTS))

        os.makedirs(os.path.dirname(scriptname), exist_ok=True)
        with open(scriptname, "wt") as output:
            output.write (template_str_rep)
