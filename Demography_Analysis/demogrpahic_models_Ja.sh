### This pipeline contains all the scripts used to simulate and select a demographic model for the Jalisco and Nayarit populations using the Akaike Inference Criterion (AIC) and calculate the uncertainty of the selected model using Godambe Information Matrix in the software dadi

## This first script makes a folded SFS file using the genomic data in a compressed VCF
## It also creates a 100 bootstrap replicates of the SFS (necessary for the uncertainty analysis
#Jalisco
python SFS_boot_Ja.py

# Nayari
python SFS_boot_Na.py

## Next we simulate the models for 1D demographics
## We performed a parameter optimization in four rounds in 100 iterations (10, 20, 30, and 40 iterations in the first, second, third, and fourth round respectively)
## The initial parameters of the next round were the best parameters of the latter round
# Jalisco
python bottlegrowth_Ja.py
python growth_Ja.py
python snm_Ja.py
python three_epoch_Ja.py
python three_epoch_inbreeding_Ja.py
python two_epoch_Ja.py

# Nayarit
python bottlegrowth_Na.py
python growth_Na.py
python snm_Na.py
python three_epoch_Na.py
python three_epoch_inbreeding_Na.py
python two_epoch_Na.py

## Next we calculate the AIC of each model
# Jalisco
python AIC_Jalisco.py

# Nayarit
pyhton AIC_Nayarit.py

## Then we obtain the Akaike weight. The probability that a given model is fitting the data in comparison with other models
# Jalisco
python AIC_weights_Ja.py

# Nayarit 
python AIC_weights_Na.py

## With a model selected (bottlegrowth in the case of both of our populations) we can estimate the uncertainty of the parameters in the model to obtain confidence intervals using the Godambe Information Matrix in dadi
# Jalisco
python Godambe_bottlegrowth_Ja.py

# Nayarit
python Godambe_bottlegrowth_Na.py

