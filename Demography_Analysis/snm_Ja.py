### This script will evaluate the Standard Neutral Model (snm_1d) for the population Jalisco

import dadi
import numpy as np

## Load the SFS file
dataset = 'Jalisco'
data_fs = dadi.Spectrum.from_file('/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Jalisco_boot/Jalisco.fs')
ns = data_fs.sample_sizes
pts_l = [max(ns)+120, max(ns)+130, max(ns)+140]

## Define the SNM model
demo_model = dadi.Demographics1D.snm
demo_model_ex = dadi.Numerics.make_extrap_func(demo_model)

## Evaluate the model (no parameters to optimize)
model_fs = demo_model_ex([], ns, pts_l)

## Calculate the log-likelihood
ll_model = dadi.Inference.ll_multinom(model_fs, data_fs)

## Calculate theta
theta0 = dadi.Inference.optimal_sfs_scaling(model_fs, data_fs)

## Output path
output_path = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/Jalisco_snm_fit.txt'
fid = open(output_path, 'w')

## Write header and result
header = ['log_likelihood', 'theta']
fid.write('\t'.join(header) + '\n')
fid.write(f"{ll_model}\t{theta0}\n")
fid.close()

## Print result
print("✅ Modelo SNM evaluado correctamente")
print(f"📊 Log-likelihood: {ll_model}")
print(f"📏 Theta: {theta0}")

