### This script will run the demographic analysis in dadi-cli

## Open Conda and create enviroment for dadi-cli usage

source ~/miniconda3/etc/profile.d/conda.sh
conda create --name dadi-env python=3.10
conda update -n base -c defaults conda
conda install -c conda-forge dadi-cli
conda activate dadi-env

## Generate folded site frequency spectrums (SFS) for Nayarit and Jalisco
dadi-cli GenerateFs --pop-ids Jalisco --pop-info input_Ja.txt --vcf diploperennis_dataJa_d5.vcf.gz --projections 86 --output Jalisco.fs

dadi-cli GenerateFs --pop-ids Nayarit --pop-info input_Na.txt --vcf diploperennis_dataNa_d5.vcf.gz --projections 178 --output Nayarit.fs

## Create a plot for the SFS

dadi-cli Plot --fs Jalisco.fs --output Jalisco.fs.pdf
dadi-cli Plot --fs Nayarit.fs --output Nayarit.fs.pdf

## Run the demographic analysis using the model growth 

dadi-cli InferDM --fs Jalisco.fs --output-prefix Jalisco_growth_fc10k --model growth --nomisid --lbounds 0.00001 0 --ubounds 10 1 --force-convergence 10000 --cpus 5

dadi-cli InferDM --fs Nayarit.fs --output-prefix Nayarit_growth_fc10k --model growth --nomisid --lbounds 0.00001 0 --ubounds 10 1 --force-convergence 10000 --cpus 5

## Create a plot that shows the deviance of the SFS data vs the SFS expected by the model

dadi-cli Plot --fs Jalisco.fs --model growth --demo-popt Jalisco_growth_fc10k.InferDM.bestfits --output Jalisco_growth-fit.pdf

dadi-cli Plot --fs Nayarit.fs --model growth --demo-popt Nayarit_growth_fc10k.InferDM.bestfits --output Nayarit_growth-fit.pdf

