### This script creates the input file for the use of the script vcf2diyabc.py 

### First, we extract the IDs of the samples within the data set

cat ~/Documentos/Z_diploperennis/data/dataset2/diploperennis_dataJa_d2.fam | awk '{print $2}' > ~/Documentos/Z_diploperennis/data/dataset2/ID_Jalisco_d2.txt
cat ~/Documentos/Z_diploperennis/data/dataset2/diploperennis_dataNa_d2.fam | awk '{print $2}' > ~/Documentos/Z_diploperennis/data/dataset2/ID_Nayarit_d2.txt

### Then we input the population information with the following R script

R Create_id_information_4vcf2diyabc.R
