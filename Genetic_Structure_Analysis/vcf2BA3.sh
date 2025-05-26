## This script transforms vcf data into BA3 format. Since the vcf data doesn't have population information, i will input that manually with another script
### This install a Brannala script that transforms the compressed vcf file into a BA3 format https://github.com/brannala/ugnix/wiki/VCF-to-BA3-File-Conversion

sudo apt install bcftools libgsl23 
git clone https://github.com/brannala/ugnix.git; chmod +x ugnix/scripts/*
cd ugnix; make all

### Transform vcf file to compressed vcf file

 ./vcftools --vcf ~/Documentos/Z_diploperennis/data/dataset1/diploperennis_data_d1.vcf --recode -c | gzip -c > ~/Documentos/Z_diploperennis/data/dataset1/diploperennis_data_d1.vcf.gz
 
### Copy the compressed  vcf to the ugnix directory

cp ~/Documentos/Z_diploperennis/data/dataset1/diploperennis_data_d1.vcf.gz -/ugnix/scripts

### Transform the vcf file into BA3 format

./bcf2ba3 diploperennis_data_d1.vcf.gz > diploperennis_data_d1.ba3

### Copy the BA3 file into the data directory

cp diploperennis_data_d9.ba3 ~/Documentos/Z_diploperennis/data/dataset1
