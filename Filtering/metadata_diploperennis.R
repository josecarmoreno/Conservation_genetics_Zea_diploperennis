##Install and load dplyr, if necessary
install.packages("dplyr")
library(dplyr)

##Load metadata of Zea diploperennis
meta_diploperennis<-read.delim("/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/metadata/ADN_pasap_diploperennis.txt", header = TRUE)

##Extract only the IDs of individuals
INDIV_diploperennis<-data.frame(meta_diploperennis$INDIV)

##Save a text document with the IDs
write.table(INDIV_diploperennis,file="/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/metadata/id_diploperennis.txt", quote=FALSE, sep="\t", 
            col.names = FALSE, row.names = FALSE)
