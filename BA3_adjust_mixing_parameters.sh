## This script reports how we adjusted the mixing parameters according to the acceptance rates

### First we perform a migration analysis with the default mixing parameters (allele frequencies=0.1, inbreeding coefficients=0.1, migration rates=0.1)

./BA3SNP -i10000000 -b1000000 -v -t ~/Documentos/Z_diploperennis/data/dataset1diploperennis_data_d1_k2.ba3 

### The acceptance rate of the migration rate (0.38) was acceptable; the allele frequencies acceptance rate (0.51) was high, so we must increase the mixing parameter; the inbreeding coefficient acceptance rate (0.11) was low, so we must decrease the mixing parameter
### We perform another analysis with the corrected mixing parameters

./BA3SNP -i10000000 -b1000000 -a0.20 -f0.05 -v -t ~/Documentos/Z_diploperennis/data/dataset1diploperennis_data_d1_k2.ba3

### The acceptance rate of the allele frequencies (0.33) is now acceptable. The acceptance rate of inbreeding coefficient (0.22) is still low, we must decrease further the mixing parameter

./BA3SNP -i10000000 -b1000000 -a0.20 -f0.03 -v -t ~/Documentos/Z_diploperennis/data/dataset1diploperennis_data_d1_k2.ba3

### Now all the acceptance rates are acceptable

