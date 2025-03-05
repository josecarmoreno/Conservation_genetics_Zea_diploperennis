##This script is for a high stringency filtering scheme. The intended purpose of the resulting data set is diversity analysis

### Filtering out sites with at least 5% of missing data

plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJa  --geno 0.05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJa_ML5
plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNa  --geno 0.05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNa_ML5

### Filtering out loci that deviate from Hardy-Weinberg proportions with a P-value<0.0001. No correction for multiple comparisons

plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJa_ML5 --hwe .0001 midp --make-bed --out diploperennis_dataJaHW
plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNa_ML5 --hwe .0001 midp --make-bed --out diploperennis_dataNaHW

### Filtering out singletons

plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJaHW --mac 1 --make-bed --out ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJaMAC
plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNaHW --mac 1 --make-bed --out ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNaMAC

### Filter out individuals with at least 15% of missing data

plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJaMAC --mind .15 --make-bed --out ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJa_d3
plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNaMAC --mind .15 --make-bed --out ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNa_d3

### Transform genomic data from plink to vcf format

plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJa_d3 --recode vcf-iid --out ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataJa_d3
plink --bfile ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNa_d3 --recode vcf-iid --out ~/Documentos/Z_diploperennis/data/dataset3/diploperennis_dataNa_d3
