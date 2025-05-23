### This script will generate the SFS file for the Jalisco population and 100 botstraps of the SFS

import pickle
import nlopt
import matplotlib.pyplot as plt
import dadi
import random
import os

## We load the input file and the population information
## We use a projection of 86 because we have 89 diploid individuals
## We indicate to create 100 bootraps (Nboot) using a chunk size of 1000000

vcf_file = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5/diploperennis_dataNa_d5.vcf.gz'
popfile = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5/input_Na.txt'
pop_ids = ['Nayarit']
projections = [178]  # Ajusta esto según datos reales
Nboot = 100
chunk_size = 1e6
output_dir = '/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/dadi/SFS/Nayarit_boot'

random.seed(12345)

## Load the data directory

dd = dadi.Misc.make_data_dict_vcf(vcf_file, popfile)

## Generate the SFS file
try:
    fs_original = dadi.Spectrum.from_data_dict(dd, pop_ids, projections, polarized=False)
    if fs_original.S().sum() == 0:
        raise ValueError("SFS sin variantes segregantes.")

    if not fs_original.folded:
        fs_original = fs_original.fold()

    fs_path = os.path.join(output_dir, 'Nayarit.fs')
    fs_original.to_file(fs_path)
    print("✅ SFS original generado: Nayarit.fs")

    ## plot the SFS and save image
    
    fig = plt.figure(figsize=(6, 4))
    fig.clear()
    dadi.Plotting.plot_1d_fs(fs_original)
    plt.title("SFS - Nayarit")
    png_path = os.path.join(output_dir, 'Nayarit.png')
    plt.savefig(png_path, dpi=300)
    plt.close()
    print("🖼️ Imagen del SFS guardada: Nayarit.png")

except Exception as e:
    print(f"❌ Falló la generación del SFS original: {e}")

## Break up the data directory into a list of directory entries for each chunk off the genome 

chunks = dadi.Misc.fragment_data_dict(dd, chunk_size)
print(f"{len(chunks)} chunks generados.")

## Make bootstraps with validation

success = 0
fail = 0
for i in range(Nboot):
    sampled_chunks = random.choices(chunks, k=len(chunks))
    dd_boot = {}
    for chunk in sampled_chunks:
        dd_boot.update(chunk)

    try:
        fs = dadi.Spectrum.from_data_dict(dd_boot, pop_ids, projections, polarized=False)
        if fs.S().sum() == 0:
            raise ValueError("SFS sin variantes segregantes.")

        if not fs.folded:
            fs = fs.fold()
        fs.to_file(os.path.join(output_dir, f'Nayarit.boot_{i}.fs'))
        success += 1
    except Exception as e:
        print(f"Bootstrap {i} falló: {e}")
        fail += 1

print(f"\n✅ {success} bootstraps generados exitosamente.")
print(f"❌ {fail} bootstraps fallaron.")

