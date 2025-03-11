### calculateDeviance.R; Patrick G. Meirmans (2013) Non-convergence in Bayesian estimation of migration rates, Molecular Ecology Resources; Supplementary Material

### This script will calculate the Bayesian Deviance from the output of BayesAss (Wilson & Rannala 2003)
### For more information on the use of the deviance, see Faubet et al. (2007)

### To use this script, run BayesAss version 3 with the -t flag to produce a trace-file
### Then set the working directory of R to the folder with the output from BayesAss

### Change this value to the actual burnin used for your MCMC run
burnin = 1000000
### Change this value to the actual sampling interval used for your MCMC run
sampling.interval = 1000

### Create a list that will contain the bayeasian deviance of every run
deviance_list <- list()  

### Start loop to calculate the bayesian deviance of every run

for (R in 1:10) {
  # Make a list with the name of the directories 
  run_dir <- paste0(R, c("st", "nd", "rd", rep("th", 7))[R], "_run")
  
  # Make the path of the files
  file_path <- paste0("/home/genetica8/Documentos/JoseCarlos/Articulo_Z_diploperennis/out/BA3/K_2/", run_dir, "/BA3trace.txt")
  
  # Make the path to save the plots of the likelihoods
  plot_path <- paste0("/home/genetica8/Documentos/JoseCarlos/Articulo_Z_diploperennis/out/BA3/K_2/", run_dir, "/Likelihood_Run_", R, ".png")
  
  # Read the data from the trace file
  trace <- read.table(file_path, header = TRUE)
  
  # Save the plots as PNG files
  png(plot_path, width = 800, height = 600)  
  
  # Plotting the likelihoods
  plot(trace$State, trace$LogProb, xlab="State", ylab="LogProb", type="l", lwd=2, col="firebrick3", font.lab=2)
  
  
  # Add a title with the name of the run
  title(main = paste("Likelihoods - Run", R))  
  
  # Draw a vertical line to indicate the end of the burnin
  abline(v=burnin, col="grey70", lty=2)
  
  # Close the graphic display to save the image
  dev.off()  
  
  # Calculate the deviance
  range = (trace$State > burnin & trace$State %% sampling.interval == 0)
  D = -2 * mean(trace$LogProb[range])
  
  deviance_list[[as.character(R)]] <- D
}

### Convert list of deviance to a dataframe
deviance_df <- data.frame(
  Run = names(deviance_list), 
  Deviance = unlist(deviance_list) 
)

### Save dataframe with the deviances as a text file
file_path <- "/home/genetica8/Documentos/JoseCarlos/Articulo_Z_diploperennis/out/BA3/K_2/deviance_list.txt"

write.table(deviance_df, file_path, sep = "\t", row.names = FALSE, quote = FALSE)

### Extract the lowest value of deviance
lowest_deviance_value <- min(deviance_df$Deviance)

### Extract the corresponding run with the lowest deviance
lowest_deviance_run <- deviance_df$Run[which.min(deviance_df$Deviance)]

# Print the lowest value of deviance with its respective run
cat("The lowest value of deviance is:", lowest_deviance_value, "in the run", lowest_deviance_run)
