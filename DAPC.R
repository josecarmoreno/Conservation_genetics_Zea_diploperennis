# Install and load adegenet and Rtools, if necessary
options(
  repos = c(
    zkamvar = "https://zkamvar.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
  )
)
install.packages("adegenet")
install.packages("Rtools")
library(adegenet)

# Defining the route of the fstat file
# We made the transformation from vcf to fstat using PGDSpider 3.0
fstat_file <- "/home/jose-carlos-moreno-juarez/Documentos/Z_diploperennis/data/dataset1/diploperennis_data_d1.dat"

# We are gonna load the fstat file
dapc_data <- read.fstat(fstat_file)

# We are gonna input manually the name of the localities
pop_vector <- c("La Embocada","La Embocada","La Embocada","La Embocada","La Embocada","La Embocada","La Embocada","La Embocada","La Embocada","La Embocada","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Tateposco","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde","Charco Verde",
                "Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Corralitos","Cuzalapa","Cuzalapa","Cuzalapa","Cuzalapa","Cuzalapa","Cuzalapa","Cuzalapa","Cuzalapa","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Las Joyas","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero","Aserradero",
                "El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","El Pino","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Zapotes","Manantlán","Manantlán","Manantlán","Manantlán","Manantlán","Manantlán","Manantlán")  # Ejemplo, reemplaza con tus poblaciones
pop_vector <- as.factor(pop_vector)

# We are gonna bind the name of the localities with the samples
dapc_data$pop <- pop_vector

#Define genetic clusters. 120 PC retained and 2 clusters selected
grp <- find.clusters(dapc_data, max.n.clust = 11)

#correspondance of the inferred clusters with the original clusters in the data set
table.value(table(pop(dapc_data), grp$grp), col.lab=paste("inf", 1:10),
            row.lab=paste("ori", 1:10))

#Discriminant Analysis of Principal Components. 80 PC retained and 1 discrimant function retained
dapc_result <- dapc(dapc_data, grp$grp)

#plot of the DAPC
scatter(dapc_result)