### This script will perform the inference for the model growth in the population Jalisco with a parameter optimization of 100 iterations
## First we import the modules we are gonna use

import dadi
import nlopt
import numpy as np

## Load the SFS file 
## Retrieve the sample size from the data
## Define the grid points

dataset = 'Jalisco'
data_fs = dadi.Spectrum.from_file('/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Jalisco_boot/Jalisco.fs')
ns = data_fs.sample_sizes
pts_l = [max(ns)+120, max(ns)+130, max(ns)+140]

## Define the model
## Wrap the demographic model in a function that utilizes grid points

demo_model = dadi.Demographics1D.growth
demo_model_ex = dadi.Numerics.make_extrap_func(demo_model)

## Define lower and upper bounds for the parameters (nu, T)

lower_bounds = [1e-4, 1e-3]
upper_bounds = [10, 10]

## Initial parameter for the first round of optimization

params = [1.5, 0.1]

## Load path to create a file which will contain the parameters if every iteration
output_path = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/Jalisco_growth_fits.txt'
fid = open(output_path, 'w')

## Attach headers to the text files with the parameters
header = ['log_likelihood', 'nu', 'T', 'theta']
fid.write('\t'.join(header) + '\n')


## Create a loop and define number of rounds and iterations
## We are making four rounds of optimization (with 10, 20, 30 and 40 iterations respectively)
## The initial parameters of the second round will be the best parameters of the first round
## and so on

rondas = [10, 20, 30, 40]

for ronda_idx, n_iter in enumerate(rondas):
    print(f"\n🔁 Iniciando ronda {ronda_idx + 1} con {n_iter} iteraciones")

    best_ll = -np.inf
    best_params = None

    for i in range(n_iter):
        ## Perturb parameters. Randomize parameters for each optimization
        p0 = dadi.Misc.perturb_params(params, fold=1,
                                      upper_bound=upper_bounds,
                                      lower_bound=lower_bounds)

        try:
            # Optimize
            popt, ll_model = dadi.Inference.opt(
                p0, data_fs, demo_model_ex, pts_l,
                lower_bound=lower_bounds,
                upper_bound=upper_bounds,
                algorithm=nlopt.LN_BOBYQA,
                maxeval=600,
                verbose=0
            )

            ## Calculate theta and save results
            model_fs = demo_model_ex(popt, ns, pts_l)
            theta0 = dadi.Inference.optimal_sfs_scaling(model_fs, data_fs)

            res = [ll_model] + list(popt) + [theta0]
            fid.write('\t'.join([str(ele) for ele in res]) + '\n')

            ## Update parameters if necessary
            if ll_model > best_ll:
                best_ll = ll_model
                best_params = popt

        except Exception as e:
            print(f"❌ Iteración {i+1} falló: {e}")

    # Use the best parameters as the initial parameters of the next round
    if best_params is not None:
        params = best_params
        print(f"✅ Mejor LL en ronda {ronda_idx + 1}: {best_ll}")
        print(f"✅ Nuevos parámetros iniciales: {params}")

fid.close()

