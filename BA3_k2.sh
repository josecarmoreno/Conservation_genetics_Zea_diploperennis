## This script performs 10 runs of a migration analysis using BayesAss 3.0.5 (Wilson and Rannala 2003) with random seeds

###make directories
mkdir ~/Documentos/Z_diploperennis/out/BA3
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/1st_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/2nd_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/3rd_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/4th_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/5th_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/6th_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/7th_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/8th_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/9th_run
mkdir ~/Documentos/Z_diploperennis/out/BA3/K_2/10th_run

### We used a random number generator to generate the random seeds
### We used 10,000,000 of iterations for MCMC, with a burnin of 1,000,000, and with and interval sample for MCMC of 1,000
### We used the mixing parameters we obtained through the adjustments in the script BA3_adjust_mixing_parameters.sh
### We also moved the output of each run to their respective directory


### 1st_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s73829 -o 1st_run.txt diploperennis_data_d9_k2.ba3

mv 1st_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/1st_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/1st_run

### 2nd_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s22120 -o 2nd_run.txt diploperennis_data_d9_k2.ba3

mv 2nd_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/2nd_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/2nd_run

### 3rd_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s76053 -o 3rd_run.txt diploperennis_data_d9_k2.ba3

mv 3rd_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/3rd_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/3rd_run

### 4th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s28944 -o 4th_run.txt diploperennis_data_d9_k2.ba3

mv 4th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/4th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/4th_run

### 5th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s45621 -o 5th_run.txt diploperennis_data_d9_k2.ba3

mv 5th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/5th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/5th_run

### 6th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s90044 -o 6th_run.txt diploperennis_data_d9_k2.ba3

mv 6th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/6th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/6th_run

### 7th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s49915 -o 7th_run.txt diploperennis_data_d9_k2.ba3

mv 7th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/7th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/7th_run

### 8th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s10086 -o 8th_run.txt diploperennis_data_d9_k2.ba3

mv 8th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/8th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/8th_run

### 9th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s38103 -o 9th_run.txt diploperennis_data_d9_k2.ba3

mv 9th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/9th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/9th_run

### 10th_run

./BA3SNP -i10000000 -b1000000 -n1000 -a0.20 -f0.03 -v -t -s57073 -o 10th_run.txt diploperennis_data_d9_k2.ba3

mv 10th_run.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/10th_run
mv BA3trace.txt ~/Documentos/Z_diploperennis/out/BA3/K_2/10th_run
