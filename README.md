# Conservation genetics of <em>Zea diploperennis</em>

### Filtering
The first script <strong>"prefiltering_schemes.sh"</strong> is to eliminate multiallelic sites and to extract <em>Zea diploperennis</em> data, this script has the <strong>"metada_diploperennis.R"</strong> script embedded. It creates a study-wide dataset with all the samples from <em>Zea diploperennis</em> and two populations subsets, one with the genomic data of Jalisco samples and another with the Nayarit samples.

<p>The script <strong>"dataset1_structure.sh"</strong> contains a filtering scheme for a study-wide data set. The resulting data set is intended for structure analysis and contains 130 individuals and 3,703 SNPs.<br>
The script <strong>"dataset2_demography.sh"</strong> contains a filtering scheme for within-population data sets. The resulting data sets are intended for demography analysis. The Jalisco data set consists of 43 individuals and 4,056 SNPs, and the Nayarit data set consists of 89 individuals and 3,363 SNPs.<br>
The script <strong>"dataset3_diversity.sh"</strong> contains a filtering scheme for a within-population data sets. The resulting data sets are intended for diversity analysis. The Jalisco data set consists of 45 individuals and 8,369 SNPs, and the Nayarit data set consists of 89 individuals and 4,385 SNPs.</p>

### Genetic Structure Analysis
<p>The script <strong>"DAPC.R"</strong> finds the number of clusters that better explains the data and then runs a Discriminant Analysis of Principal Components with such number of clusters using the R package adegenet (Jombart and Ahmed 2011).</p>

<p>The script <strong>"admixture_d1".sh</strong> performs an admixture analysis using the software ADMIXTURE (Alexander et al. 2009) for a K of 1-11. The R script <strong>"plot_admixture.R"</strong> plots the cross-error for each K, plots ancestry factors (Q) for K 1-11, and save the plots of the Q values.</p>

<p>The script <strong>"vcf2BA3.sh"</strong> transforms a vcf file to BA3 format to perform migration analysis in BayesAss 3.0.5 (Wilson and Rannala 2003). Then we assign the population data manually with the R script <strong>"input_population_ID_BayesAss_2k.R"!!!!</strong>. With the <strong>"BA3_adjust_mixing_parameters.sh"</strong> we adjusted the mixing parameters accordingly with the acceptance rates. We perform ten analysis of migration with different seeds, using 10,000,000 MCMC and with a 1,000,000 burnin, and we ask for the trace files using the script <strong>"BA3_k2.sh"</strong>. Finally, we used <strong>"Bayesian_deviance_k2.R"</strong>, found in Meirmans (2014) to select the run with the lowest bayesian deviance.</p>

### Demography analysis
<p>We used the <strong>"vcf2compressedvcf.sh"</strong> script to convert the vcf fomrmat to a compressed vcf format, necessary for the use of dadi (Gutenkunst et al. 2009). Then we used the <strong>"pop_info.R"</strong> script to create a text file with the population information, which will be the input to create the SFS of the populations in dadi.<br>
We used the script <strong>"demographic_models.sh"</strong> that contains the pipeline of the workflow to simulate and select the demographic model that better fits the data of each population. The pipeline contains a series of python scripts that perform the following actions: <strong>"SFS_boot_*.py"</strong> creates the SFS and 100 bootstraps of the SFS. Then the scripts <strong>"bottlegrowth_*.py", "growth_*.py", "snm_*.py", "three_epoch_*.py", "three_epoch_inbreeding_*.py", and "two_epoch_*.py"</strong> simulate the demographic models containend in 1D demography dadi, it perform an optimization of parameters through 100 iterations in four rounds (10, 20, 30, and 40 iterations in the first, second, third, and fourth round respectively) The initial parameters of the next round were the best parameters of the latter round. <strong>"AIC_*.py</strong> calculates the Akaike Inference Criterion (AIC) of each model, then with <strong>"AIC_weights_*.py</strong> we calculate the Akaike weights, which can be interpreted as the probabilty that a given model is fitting the data. Finally, <strong>"Godambe_bottlegrowth_*.py"</strong> estimates the uncertainty of the parameters of the chosen model using the Godambre Information Matrix in the software dadi</p>

### References
Jombart, T., & Ahmed, I. (2011). adegenet 1.3-1: new tools for the analysis of genome-wide SNP data. Bioinformatics, 27(21), 3070-3071. <br>
Alexander, D. H., Novembre, J., & Lange, K. (2009). Fast model-based estimation of ancestry in unrelated individuals. Genome research, 19(9), 1655-1664. <br>
Wilson, G. A., & Rannala, B. (2003). Bayesian inference of recent migration rates using multilocus genotypes. Genetics, 163(3), 1177-1191. <br>
Meirmans, P. G. (2014). Nonconvergence in B ayesian estimation of migration rates. Molecular ecology resources, 14(4), 726-733. <br>
Gutenkunst, R. N., Hernandez, R. D., Williamson, S. H., & Bustamante, C. D. (2009). Inferring the joint demographic history of multiple populations from multidimensional SNP frequency data. PLoS genetics, 5(10), e1000695.
