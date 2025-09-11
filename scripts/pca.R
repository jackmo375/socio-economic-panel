#!/usr/bin/env Rscript

library(tidyverse)

readRDS('./data/processed/data_mapped.RDS') -> data_mapped

data_mapped %>% select(einkommenj1, einkommenj2, einkommenm1, einkommenm2) -> data_subset

data_subset %>% as.matrix() -> data_matrix

pca <- prcomp(data_matrix, scale=TRUE)

plot(pca$x[,1], pca$x[,2])

pca.var <- pca$sdev^2
pca.var.per <- round(pca.var/sum(pca.var)*100, 1)

barplot(pca.var.per, main="Scree Plot", xlab="Principal Component", ylab="Percent Variation")

loading_scores <- pca$rotation[,1]
