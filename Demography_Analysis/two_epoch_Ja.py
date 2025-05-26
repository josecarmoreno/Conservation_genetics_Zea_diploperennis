### This script will perform inference for the model two_epoch in the population Jalisco
### with parameter optimization in multiple rounds

import dadi
import nlopt
import numpy as np

# Load the SFS file
dataset = 'Jalisco'
data_fs = dadi.Spectrum.from_file('/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Jalisco_boot/Jalisco.fs')
ns = data_fs.sample_sizes
pts_l = [max(ns)+120, max(ns)+130, max(ns)+140]

# Define the two_epoch model
demo_model = dadi.Demographics1D.two_epoch
demo_model_ex = dadi.Numerics.make_extrap_func(demo_model)

# Define parameter bounds: (nu, T)
lower_bounds = [1e-4, 1e-3]
upper_bounds = [10, 10]

# Initial parameter guesses
params = [1.5, 0.1]

# Output path for results
output_path = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/Jalisco_twoepoch_fits.txt'
fid = open(output_path, 'w')

# Write headers
header = ['log_likelihood', 'nu', 'T', 'theta']
fid.write('\t'.join(header) + '\n')

# Optimization rounds and number of iterations
rondas = [10, 20, 30, 40]

for ronda_idx, n_iter in enumerate(rondas):
    print(f"\n🔁 Iniciando ronda {ronda_idx + 1} con {n_iter} iteraciones")

    best_ll = -np.inf
    best_params = None

    for i in range(n_iter):
        # Perturb parameters
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

            # Calculate theta
            model_fs = demo_model_ex(popt, ns, pts_l)
            theta0 = dadi.Inference.optimal_sfs_scaling(model_fs, data_fs)

            # Save results
            res = [ll_model] + list(popt) + [theta0]
            fid.write('\t'.join([str(ele) for ele in res]) + '\n')

            # Update best result
            if ll_model > best_ll:
                best_ll = ll_model
                best_params = popt

        except Exception as e:
            print(f"❌ Iteración {i+1} falló: {e}")

    # Use best parameters for next round
    if best_params is not None:
        params = best_params
        print(f"✅ Mejor LL en ronda {ronda_idx + 1}: {best_ll}")
        print(f"✅ Nuevos parámetros iniciales: {params}")

fid.close()

