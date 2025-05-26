### This script performs an admixture analysis with the data set 1 of Zea diploperennis

## Make a directory to save the output

mkdir -p ~/Documentos/Z_diploperennis/out/admixture/admixture_d1 

## Performs the admixture for a K 1-11

for K in 1 2 3 4 5 6 7 8 9 10 11 ; \
do ./admixture --cv -B100000 ~/Documentos/Z_diploperennis/data/dataset1/diploperennis_data_d1.bed $K | tee ~/Documentos/Z_diploperennis/out/admixture/admixture_d1/log${K}.out;done

## Move the Q and P output to the output directory

mv {*.P,*.Q} ~/Documentos/Z_diploperennis/out/admixture/admixture_d1 

## Save the results of probability for each K in a single text file

grep -h CV ~/Documentos/Z_diploperennis/out/admixture/admixture_d1/log*.out > ~/Documentos/Z_diploperennis/out/admixture/admixture_d1/zdiploperennis_d1_Kerror.txt
