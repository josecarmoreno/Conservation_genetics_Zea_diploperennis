## This script makes a graph with the K errors and plots of the ancestry fractions (Q) for each K.
### We're gonna need the output of the scripts admixture_d1.sh
### Install and load the packages we're gonna use, if necessary

install.packages("ggplot2")
install.packages("tidyr")
install.packages("dplyr")
install.packages("readr")
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)

### Obtain the K that better fits the data
### Load the K error file

k.error<- read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/admixture/admixture_d1/zdiploperennis_d1_Kerror.txt", header = F, sep = ":")
rownames(k.error)<- c("k=1", "k=2", "k=3", "k=4", "k=5", "k=6", "k=7", "k=8", "k=9", "k=10", "k=11")

### Make the plot for the K error

e.plot<- ggplot(data=k.error, aes(x=1:11, y=V2)) + geom_point() + geom_line()
e.plot + xlab("k") + ylab("Error")

## Make the plot for K=1-11

### Load metadata

samples_meta<-read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/metadata/ADN_pasap_diploperennis.txt", header=TRUE, sep="\t")

### Change localities names

samples_meta <- samples_meta %>%
  mutate(LUGAR = case_when(
    LUGAR == "SA_Milpillas_La_Embocada_Arroyo_San_Andrés" ~ "La_Embocada",
    LUGAR == "SA_Milpillas_Tateposco_Arroyo_La_Mesa" ~ "Tateposco",  
    LUGAR == "SA_Milpillas_El_Rincón_Arroyo_Charco_Verde" ~ "Charco_Verde",
    LUGAR == "San_Miguel_Cuzalapa" ~ "Cuzalapa",
    LUGAR == "Las_Joyas_Las_Playas" ~ "Las_Joyas",  
    LUGAR == "San_Andrés_Milpillas_Camino_al_Aserradero" ~ "Aserradero",
    LUGAR == "San_Andrés_Milpillas_Potrero_El_Pino" ~ "El_Pino",
    LUGAR == "San_Andrés_Milpillas_Los_Zapotes" ~ "Zapotes",
    TRUE ~ LUGAR  # Mantener los nombres que no cambian
  ))

### Load the names of the samples 

samples_names<-read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/dataset1/diploperennis_data_d1.fam", header=FALSE, sep=" ") %>%
  select(., V2) %>%
  rename(., INDIV=V2)

### Assign locality to sample names

samples_names <- left_join(samples_names, samples_meta, by = "INDIV")

### Create a list for the admixture plots

plots_list <- list()

## Create loop for plotting and saving the plot of K 1-11

for (K in 1:11) {
  
  ### Load the Q file
  
  Qval <- read.table(paste0("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/out/admixture/admixture_d1/diploperennis_data_d1.", K, ".Q"))
  
  ### Assign name to the column
  
  names(Qval) <- paste0("K", 1:ncol(Qval))
  
  ### Add the samples ID and locality to the Q file
  
  Qval <- cbind(INDIV = samples_names$INDIV, LUGAR = samples_names$LUGAR, Latitud = samples_meta$LATITUDE, Qval)
  
  ### Transform the Q values to long format
  
  Qval_long <- gather(Qval, key=Kgroup, value=Qadmixture, 4:ncol(Qval))
  
  ### Sort samples by latitude
  
  Qval_long$INDIV <- factor(Qval_long$INDIV, levels = Qval_long$INDIV[order(Qval$Latitud)])
  
  ### Calculate postions of the localities within the plot
  
  localidad_positions <- Qval_long %>%
    group_by(LUGAR) %>%
    summarize(min_x = min(as.numeric(INDIV)), 
              max_x = max(as.numeric(INDIV)))  
  
  ### Generate plot
  
  plot <- ggplot(Qval_long, aes(x=INDIV, y=Qadmixture, fill=Kgroup)) + 
    geom_col() + 
    theme(axis.text.x = element_blank(), 
          axis.ticks.x = element_blank(),
          axis.title.x = element_blank()) +
    ggtitle(paste("Admixture Plot for K =", K)) +
    
    ### Add brackets 
    
    geom_segment(data = localidad_positions, 
                 aes(x = min_x, xend = max_x, y = 1.05, yend = 1.05), 
                 inherit.aes = FALSE, size = 0.5) +
    
    ### Add locality name in the brackets
    
    geom_text(data = localidad_positions, 
              aes(x = (min_x + max_x) / 2, y = 1.1, label = LUGAR), 
              inherit.aes = FALSE, size = 2)
  
  ### Save plot in the list
  plots_list[[K]] <- plot
  
  ### Save plot
  
  ggsave(paste0("Admixture_K", K, "_localidades.png"), plot, width=8, height=4)
}

### Show plots tho see if everything went alright
plots_list[[1]]
plots_list[[2]]