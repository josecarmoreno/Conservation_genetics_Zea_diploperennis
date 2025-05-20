### This script is for the convertion of the genomic data from vcf format to compressed vcf for its usage in dadi-cli

## We're gonna move to the directory where is the genomic data
cd ~/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5

##Conversion of the data
vcftools --vcf diploperennis_dataJa_d5.vcf --recode -c | gzip -c > diploperennis_dataJa_d5.vcf.gz

vcftools --vcf diploperennis_dataNa_d5.vcf --recode -c | gzip -c > diploperennis_dataNa_d5.vcf.gz
