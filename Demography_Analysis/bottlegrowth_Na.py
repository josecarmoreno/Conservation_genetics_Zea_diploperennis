### This script will perform the inference for the model bottlegrowth in the population Nayarit
### with a parameter optimization of 100 iterations across 4 rounds

import dadi
import nlopt
import numpy as np

## Load the SFS file 
dataset = 'Nayarit'
data_fs = dadi.Spectrum.from_file('/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Nayarit_boot/Nayarit.fs')
ns = data_fs.sample_sizes
pts_l = [max(ns)+120, max(ns)+130, max(ns)+140]

## Define the bottlegrowth model
demo_model = dadi.Demographics1D.bottlegrowth
demo_model_ex = dadi.Numerics.make_extrap_func(demo_model)

## Define bounds: nuB (bottleneck), nuF (final size), T (time of bottleneck)
lower_bounds = [1e-4, 1e-4, 1e-3]
upper_bounds = [10, 10, 10]

## Initial guess: [nuB, nuF, T]
params = [0.5, 1.5, 0.1]

## Output file
output_path = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/Nayarit_bottlegrowth_fits.txt'
fid = open(output_path, 'w')

## Write header
header = ['log_likelihood', 'nuB', 'nuF', 'T', 'theta']
fid.write('\t'.join(header) + '\n')

## Define optimization rounds
rondas = [10, 20, 30, 40]

for ronda_idx, n_iter in enumerate(rondas):
    print(f"\n🔁 Iniciando ronda {ronda_idx + 1} con {n_iter} iteraciones")

    best_ll = -np.inf
    best_params = None

    for i in range(n_iter):
        ## Perturb parameters
        p0 = dadi.Misc.perturb_params(params, fold=1,
                                      upper_bound=upper_bounds,
                                      lower_bound=lower_bounds)

        try:
            ## Optimization
            popt, ll_model = dadi.Inference.opt(
                p0, data_fs, demo_model_ex, pts_l,
                lower_bound=lower_bounds,
                upper_bound=upper_bounds,
                algorithm=nlopt.LN_BOBYQA,
                maxeval=600,
                verbose=0
            )

            ## Get model and theta
            model_fs = demo_model_ex(popt, ns, pts_l)
            theta0 = dadi.Inference.optimal_sfs_scaling(model_fs, data_fs)

            ## Save results
            res = [ll_model] + list(popt) + [theta0]
            fid.write('\t'.join([str(ele) for ele in res]) + '\n')

            ## Track best parameters
            if ll_model > best_ll:
                best_ll = ll_model
                best_params = popt

        except Exception as e:
            print(f"❌ Iteración {i+1} falló: {e}")

    ## Update initial parameters for next round
    if best_params is not None:
        params = best_params
        print(f"✅ Mejor LL en ronda {ronda_idx + 1}: {best_ll}")
        print(f"✅ Nuevos parámetros iniciales: {params}")

fid.close()

