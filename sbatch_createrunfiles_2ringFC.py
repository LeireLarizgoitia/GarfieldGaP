import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os


"Y/p (photons electron**−1 cm**−1 bar**−1)= 81E/p − 47 : C.M.B. Monteiro et al. / Physics Letters B 668 (2008) 167–170"

pressure = np.arange(2.5,9.5,1.) #bar pressure
#print(pressure)

vgate_5kVdrift = np.concatenate((np.arange(-15000,-4500,500), np.arange(-4750,-2250, 250)))
#print(vgate_5kVdrift)

path = "/scratch/llarizgoitia/GarfieldGaP/"

path_real = "/Users/llarizgoitialive/Library/CloudStorage/OneDrive-Personal/GanESS/GarfieldCode/GarfieldGaP/"
template = open(path+"Electroluminescence/jobs/sbatchMesh2ringFC_job.sh", "rt").read()

MPHFILE= path+"ComsolData/mesh_GaP3D_photoedge"
MATFILE= path+"ComsolData/material_GaP3D"
N_EVENTS = 1000

for j in range(0,len(pressure)):
    GASFILE = path+"Electroluminescence/gases/ar_"+str(pressure[j])+"bar"
    for i in range(0,len(vgate_5kVdrift)):
        DATAFILE = path+"ComsolData/ELscan/electricpotentialGate"+str(vgate_5kVdrift[i])+"V"
        jobname = "Mesh"+str(vgate_5kVdrift[i])+"V_"+str(pressure[j])+"bar"
        pressure_folder = "Mesh_"+str(pressure[j])+"bar"
        el_folder = "job-"+jobname
        scriptname = "sbatch_scripts_2ringFC/"+pressure_folder+"/"+el_folder+"/"+jobname +".sh"
        print(scriptname)
        template_str_rep = template.replace("$1", jobname).replace("$2", str(pressure[j])).replace("$3", GASFILE).replace("$4", MPHFILE).replace("$5", DATAFILE).replace("$6", MATFILE).replace("$7", str(N_EVENTS))

        os.makedirs(os.path.dirname(scriptname), exist_ok=True)
        with open(scriptname, "wt") as output:
            output.write (template_str_rep)

pressure = [1.5]
vgate_3kVdrift = np.arange(-4000,-1200, 200)
#print(vgate_3kVdrift)

GASFILE = path+"Electroluminescence/gases/ar_"+str(pressure[0])+"bar"
for i in range(0,len(vgate_3kVdrift)):
    DATAFILE = path+"ComsolData/ELscan_3kVdrift/electricpotentialGate"+str(vgate_3kVdrift[i])+"V"
    jobname = "Mesh"+str(vgate_3kVdrift[i])+"V_"+str(pressure[0])+"bar"
    pressure_folder = "Mesh_"+str(pressure[0])+"bar"
    el_folder = "job-"+jobname
    scriptname = "sbatch_scripts_2ringFC/"+pressure_folder+"/"+el_folder+"/"+jobname +".sh"
    print(scriptname)
    template_str_rep = template.replace("$1", jobname).replace("$2", str(pressure[0])).replace("$3", GASFILE).replace("$4", MPHFILE).replace("$5", DATAFILE).replace("$6", MATFILE).replace("$7", str(N_EVENTS))

    os.makedirs(os.path.dirname(scriptname), exist_ok=True)
    with open(scriptname, "wt") as output:
        output.write (template_str_rep)
