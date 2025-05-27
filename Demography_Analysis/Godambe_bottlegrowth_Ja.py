### This script performs a uncertainty analysis with a Godambe Information Matrix using the software dadi
## Import the modules we are gonna use

import dadi
import numpy as np
import glob

## Define the name of the dataset

dataset = 'Jalisco'

## Define the path where we have the SFS bootstraps

boots_fids = glob.glob('/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Jalisco_boot/Jalisco.boot_*.fs')
boots_spectra = [dadi.Spectrum.from_file(fid) for fid in boots_fids]

## Load the SFS (the "original SFS", not the bootstraps)

data_fs = dadi.Spectrum.from_file('/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Jalisco_boot/Jalisco.fs')
ns = data_fs.sample_sizes
pts_l = [max(ns)+120, max(ns)+130, max(ns)+140]

## Define the model

demo_model = dadi.Demographics1D.bottlegrowth
demo_model_ex = dadi.Numerics.make_extrap_func(demo_model)

## Input the optimal parameters we obtained during the simulations

popt = [0.00124, 0.05126, 0.01247]  # [nuB, nuF, T]

## Create the output file and define the path

output_file = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/Jalisco_bottlegrowth_uncertainty.txt'
fi = open(output_file, 'w')
fi.write(f'Optimized parameters: {popt}\n\n')

## Verify if the model can be evaluated with the optimal parameters

model = demo_model_ex(popt, ns, pts_l)
print(model)

## Proving different step sizes
for eps in [0.01, 0.001, 0.0001]:
    uncerts_adj = dadi.Godambe.GIM_uncert(demo_model_ex, pts_l, boots_spectra, popt, data_fs, eps=eps)
    fi.write(f'Estimated 95% uncerts (with step size {eps}): {1.96 * uncerts_adj[:-1]}\n')
    fi.write(f'Lower bounds of 95% confidence interval : {popt - 1.96 * uncerts_adj[:-1]}\n')
    fi.write(f'Upper bounds of 95% confidence interval : {popt + 1.96 * uncerts_adj[:-1]}\n\n')

fi.close()
print(f"✅ Godambe uncertainties guardadas en: {output_file}")

