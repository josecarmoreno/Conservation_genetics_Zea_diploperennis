### This script estimates the Akaike Inference Criterion (AIC) on each model simulated on Jalisco
## Import the modules we will use in this script

import pandas as pd
import glob
import os

## Create a dictionary in which the results of the AIC will be registered

aic_results = {}

## Define the number of parameters per model

param_counts = {
    'growth': 2,
    'bottlegrowth': 3,
    'snm': 0,
    'threeepoch': 4,
    'threeepochinbreeding': 5,
    'twoepoch': 2
}

## Define path where there are the results of the simulated models

folder = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/'

## Search for all the files Jalisco_*_fits.txt

files = glob.glob(os.path.join(folder, 'Nayarit_*_fits.txt'))

## Loop for the extraction of the best likelihood of each model and the estimation of the AIC of each model

for file in files:
    model_name = os.path.basename(file).replace('Nayarit_', '').replace('_fits.txt', '')

    df = pd.read_csv(file, sep='\t')

    if df.empty or 'log_likelihood' not in df.columns:
        continue

    max_ll = df['log_likelihood'].max()
    k = param_counts.get(model_name, None)

    if k is None:
        print(f"⚠️ No se conoce el número de parámetros para el modelo '{model_name}', omitiendo.")
        continue

    aic = 2 * k - 2 * max_ll
    aic_results[model_name] = {'logL': max_ll, 'k': k, 'AIC': aic}

## Print and sort the AIC values

aic_df = pd.DataFrame.from_dict(aic_results, orient='index')
aic_df = aic_df.sort_values('AIC')
print("\n📊 Comparación de modelos con AIC:")
print(aic_df)

## Save the values in a .txt file

output_file = os.path.join(folder, 'AIC_results_Na.txt')
aic_df.to_csv(output_file, sep='\t', index=True)
print(f"\n💾 Resultados guardados en: {output_file}")
