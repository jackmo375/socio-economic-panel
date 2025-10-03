#!/usr/bin/env Rscript

library(tidyverse)
library(missForest)

readRDS('./data/processed/data_transformed.RDS') -> data_transformed

missForest(as.data.frame(data_transformed[,2:ncol(data_transformed)])) -> impute_out
cbind(data_transformed[,1],impute_out$ximp) %>% as_tibble() -> data_imputed

data_imputed %>% saveRDS('./data/processed/data_imputed.RDS')
impute_out %>% saveRDS('./data/processed/impute_output.RDS')