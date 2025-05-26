# If necessary, download the package dplyr
install.packages("dplyr")
library(dplyr)

# Load the ids of Nayarit and Jalisco from the genomic data file
ID_Jalisco <- read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5/ID_Jalisco_d5.txt", header = F, sep = "\t")
ID_Nayarit <- read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5/ID_Nayarit_d5.txt", header = F, sep = "\t")                         


# Load Z. diploperennis metadata
metadata <- read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/metadata/metadatos_Zdiploperennis.txt", header = T, sep = "\t") 

# Filter out the individuals that arent present in the dataset 5 and select columns "INDIV" and "ESTADO"
# Jalisco
filtered_metadataJa <- metadata %>%
  semi_join(ID_Jalisco, by = c("INDIV" = "V1")) %>% 
  select(INDIV, ESTADO) 

# Nayarit
filtered_metadataNa <- metadata %>%
  semi_join(ID_Nayarit, by = c("INDIV" = "V1")) %>% 
  select(INDIV, ESTADO) 

#
write.table(filtered_metadataJa, "/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5/input_Ja.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(filtered_metadataNa, "/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/Filtering/HS_demography/dataset5/input_Na.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
