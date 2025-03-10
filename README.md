# Conservation genetics of <em>Zea diploperennis</em>

### Filtering
The first script <strong>"prefiltering_schemes.sh"</strong> is to eliminate multiallelic sites and to extract <em>Zea diploperennis</em> data, this script has the <strong>"metada_diploperennis.R"</strong> script embedded- Itt creates a study-wide dataset with all the samples from <em>Zea diploperennis</em> and two populations subsets, one with the genomic data of Jalisco samples and another with the Nayarit samples.

<p>The script <strong>"dataset1_structure.sh"</strong> contains a filtring scheme for a study-wide data set. The resulting data set is intended for structure analysis and contains 130 individuals and 3,703 SNPs.<br>
The script <strong>"dataset2_demography.sh"</strong> contains a filtering scheme for within-population data sets. The resulting data sets are intended for demography analysis. The Jalisco data set consists of 43 individuals and 4,056 SNPs, and the Nayarit data set consists of 89 individuals and 3,363 SNPs.<br>
The script <strong>"dataset3_diversity.sh"</strong> contains a filtering scheme for a within-population data sets. The resulting data sets are intended for diversity analysis. The Jalisco data set consists of 45 individuals and 8,369 SNPs, and the Nayarit data set consists of 89 individuals and 4,385 SNPs.</p>

### Genetic Structure Analysis
<p>The script <strong>"DAPC.R"</strong> finds the number of clusters that better explains the data and then runs a Discriminant Analysis of Principal Components with such number of clusters using the R package adegenet (Jombart and Ahmed 2011).</p>

<p>The script <strong>"admixture_d1".sh</strong> performs an admixture analysis using the software ADMIXTURE (Alexander et al. 2009) for a K of 1-11. The R script <strong>"plot_admixture.R"</strong> plots the cross-error for each K, plots ancestry factors (Q) for K 1-11, and save the plots of the Q values.</p>

<p>The script <strong>"vcf2BA3.sh"</strong> transforms a vcf file to BA3 format to perform migration analysis in BayesAss 3.0.5 (Wilson and Rannala 2003).</p>
