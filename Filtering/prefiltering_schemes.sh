##Load the raw_MinDepth2.h5 file in Tassel 5.0 
###Export data in vcf format under the name T4465_S955690.vcf 4,465 individuals and 955,690 sites

##Filter out multiallelic sites. Only leaving biallelic sites

plink2 --vcf ~/Documentos/Z_diploperennis/data/T4465_S955690.vcf --max-alleles 2 make-bed --out ~/Documentos/Z_diploperennis/data/T4465bi

###The resulting data set had 4465 individuals and 825,570 sites

##Extract the genomic data of *Zea diploperennis*
###First, we need to create a list with the individuals IDs 
###Correction on the character format of the metadata file

iconv -f latin1 -t utf8 ~/Documentos/Z_diploperennis/metadata/ADN_pasap_4465.txt | tr '\r' '\n' > ~/Documentos/Z_diploperennis/metadata/ADN_pasap_4465corregido.txt
grep diploperennis ~/Documentos/Z_diploperennis/metadata/ADN_pasap_4465corregido.txt > ~/Documentos/Z_diploperennis/metadata/ADN_pasap_diploperennis.txt

##The R script extract only the IDs of samples

Rscript ~/Documentos/Z_diploperennis/bin/metadata_diploperennis.R

##Now we extract the population ID and the sample ID out of the .fam file. This file still contains the information of all the *Zea* genus

cat ~/Documentos/Z_diploperennis/data/T4465bi.fam | awk '{print $1"\t"$2}' > ~/Documentos/Z_diploperennis/metadata/keep_all.txt 

##We use the IDs of *Zea diploperennis* to extract a text file with the population IDs and sample IDs

grep -Fwf ~/Documentos/Z_diploperennis/metadata/id_diploperennis.txt keep_all.txt > ~/Documentos/Z_diploperennis/metadata/keep_diploperennis.txt

###Extraction of genomic data with the latter list (keep_diploperennis.txt)

./plink --bfile ~/Documentos/Z_diploperennis/data/T4465bi --recode --keep ~/Documentos/Z_diploperennis/metadata/keep_diploperennis.txt --make-bed --out ~/Documentos/Z_diploperennis/data/diploperennis_data

##We are gonna create other two data set, one only with the Jalisco data and one with the Nayarit data. For within-sample filtering schemes

###We are gonna extract the Nayarit metada

grep Nayarit ~/Documentos/Z_diploperennis/metadata/ADN_pasap_diploperennis.txt > ~/Documentos/Z_diploperennis/metadata/meta_Nayarit.txt

###Then we extract the IDs of Nayarit
cat ~/Documentos/Z_diploperennis/metadata/meta_Nayarit.txt | awk '{print $1}' > ~/Documentos/Z_diploperennis/metadata/keep_Nayarit.txt

#Extraction of Jalisco genomic data

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_data --make-bed --recode --remove ~/Documentos/Z_diploperennis/metadata/keep_Nayarit.txt --out ~/Documentos/Z_diploperennis/data/diploperennis_dataJa

#Extraction of Nayarit genomic data

plink --bfile ~/Documentos/Z_diploperennis/data/diploperennis_data --make-bed --recode --keep ~/Documentos/Z_diploperennis/metadata/keep_Nayarit.txt --out ~/Documentos/Z_diploperennis/data/diploperennis_dataNa




