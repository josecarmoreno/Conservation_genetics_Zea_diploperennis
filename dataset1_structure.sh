##This script is for a high stringency filtering scheme. The intended purpose of the resulting data set is genetic structure analysis

### Filtering out sites with at least 5% of missing data

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis  --geno 0.05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_data_ML5

### Filtering out loci that deviate from Hardy-Weinberg proportions with a P-value<0.00001. No correction for multiple comparisons

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_data_ML5 --hwe .00001 midp --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataHW

### Filtering out loci under linkage disequilibrium (LD) r2=0.2
### Makes a list of loci under LD

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataHW --indep-pairwise 50 10 0.2 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataLD

### Extraction of loci under LD 

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataHW --make-bed --recode --extract ~/Documentos/Z_diploperennis/data/diploperennis_dataLD.prune.in --out ~/Documentos/Z_diploperennis/data/diploperennis_dataLD

### Filtering out singletons

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataLD --mac 1 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_dataMAC

### Filter out individuals with at least 5% of missing data

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_dataMAC --mind .05 --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_data_d1

### Transform genomic data from plink to vcf format

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_data_d1 --recode vcf-iid --out ~/Documentos/Z_diploperennis/data/diploperennis_data_d1


