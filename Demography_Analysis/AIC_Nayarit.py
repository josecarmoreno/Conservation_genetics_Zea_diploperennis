import pandas as pd
import glob
import os

# Diccionario para registrar los resultados
aic_results = {}

# Número de parámetros por modelo
param_counts = {
    'growth': 2,
    'bottlegrowth': 3,
    'snm': 0,
    'threeepoch': 4,
    'threeepochinbreeding': 5,
    'twoepoch': 2
}

# Carpeta donde están tus archivos
folder = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/demographic_models/'

# Buscar todos los archivos *_fits.txt
files = glob.glob(os.path.join(folder, 'Nayarit_*_fits.txt'))

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

# Mostrar los resultados ordenados por AIC
aic_df = pd.DataFrame.from_dict(aic_results, orient='index')
aic_df = aic_df.sort_values('AIC')
print("\n📊 Comparación de modelos con AIC:")
print(aic_df)

