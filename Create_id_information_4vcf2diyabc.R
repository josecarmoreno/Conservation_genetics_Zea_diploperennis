# If necessary, install and load the package dplyr
install.packages("dplyr")
library(dplyr)

# Load the ids of Nayarit and Jalisco
ID_Jalisco <- read.delim("/home/jose-carlos-moreno-juarez//Documentos/Z_diploperennis/data/dataset2/ID_Jalisco_d2.txt", header = F, sep = "\t")
ID_Nayarit <- read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/dataset2/ID_Nayarit_d2.txt", header = F, sep = "\t")                         


# Load Z. diploperennis metadata
metadata <- read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/metadata/ADN_pasap_diploperennis.txt", header = T, sep = "\t") 

# We extract only the individuals present in ID_Jalisco and we extract the columns "INDIV" and "ESTADO"
filtered_metadataJa <- metadata %>%
  semi_join(ID_Jalisco, by = c("INDIV" = "V1")) %>%  
  select(INDIV, ESTADO) %>%  
  mutate(SEX = 9) %>%  # Create a column with the sex of the individuals, since they are monoecious, we assign a 9
  relocate(SEX, .after = INDIV)  # Place the column sex between indiv and estado for formatting

# We extract only the individuals present in ID_Nayarit and we extract the columns "INDIV" and "ESTADO"
filtered_metadataNa <- metadata %>%
  semi_join(ID_Nayarit, by = c("INDIV" = "V1")) %>% 
  select(INDIV, ESTADO) %>%  
  mutate(SEX = 9) %>%  # Create a column with the sex of the individuals, since they are monoecious, we assign a 9
  relocate(SEX, .after = INDIV)  # Place the column sex between indiv and estado for formatting

# Save the output as a table
write.table(filtered_metadataJa, "/home/jose-carlos-moreno-juarez//Documentos/Z_diploperennis/data/dataset2/input_Ja.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table(filtered_metadataNa, "/home/jose-carlos-moreno-juarez//Documentos/Z_diploperennis/data/dataset2/input_Na.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)