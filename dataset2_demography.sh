##This script is for a high stringency filtering scheme. The intended purpose of the data set is demographic analysis

### Filtering out sites with at least 5% of missing data

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataJa  --geno 0.05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJa_ML5
plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataNa  --geno 0.05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNa_ML5

### Filtering out loci that deviate from Hardy-Weinberg proportions with a P-value<0.01. No correction for multiple comparisons

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataJa_ML5 --hwe .01 midp --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJaHW
plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataNa_ML5 --hwe .01 midp --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNaHW

### Filtering out loci under linkage disequilibrium (LD) r2=0.2
### Makes a list of loci under LD

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataJaHW --indep-pairwise 50 10 0.2 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJaLD
plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataNaHW --indep-pairwise 50 10 0.2 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNaLD

### Extraction of loci under LD 

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataJaHW --make-bed --recode --extract ~/Documentos/Z_diploperennis/data/diploperennis_dataJaLD.prune.in --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJaLD
plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataNaHW --make-bed --recode --extract ~/Documentos/Z_diploperennis/data/diploperennis_dataJaLD.prune.in --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNaLD

### Filter out individuals with at least 5% of missing data

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataJaLD --mind .05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJa_d2
plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataNaLD --mind .05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNa_d2

### Transform genomic data from plink to vcf format

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataJa_d2 --recode vcf-iid --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJa_d2
plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataNa_d2 --recode vcf-iid --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNa_d2
