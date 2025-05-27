### This script calculates the Akaike weights off the different model and gives out the probability that certain model is explaining the data
## Import the modules we are gonna use 

import pandas as pd
import numpy as np
import os

## Define the path where the AIC are located

folder = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/'

## Read the file AIC_results.txt

input_file = os.path.join(folder, 'AIC_results_Ja.txt')
aic_df = pd.read_csv(input_file, sep='\t', index_col=0)

## Calculate the ΔAIC (AIC - AIC_min) of each model

aic_min = aic_df['AIC'].min()
aic_df['Delta_AIC'] = aic_df['AIC'] - aic_min

## Calculate the Akaike weights

aic_df['exp_half_delta'] = np.exp(-0.5 * aic_df['Delta_AIC'])
sum_exp_half_delta = aic_df['exp_half_delta'].sum()
aic_df['AIC_weight'] = aic_df['exp_half_delta'] / sum_exp_half_delta

## Sort by AIC

aic_df = aic_df.sort_values('AIC')

## Show results

print("\n📊 Comparación de modelos con pesos de Akaike:")
print(aic_df[['logL', 'k', 'AIC', 'Delta_AIC', 'AIC_weight']])

## Save the output in a .txt file

output_file = os.path.join(folder, 'AIC_weights_Ja.txt')
aic_df[['logL', 'k', 'AIC', 'Delta_AIC', 'AIC_weight']].to_csv(output_file, sep='\t', index=True)
print(f"\n💾 Resultados guardados en: {output_file}")
