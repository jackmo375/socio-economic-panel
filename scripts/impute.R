#!/usr/bin/env Rscript

library(tidyverse)
library(missForest)

readRDS('./data/processed/data_mapped.RDS') -> data_mapped

missForest(as.data.frame(data_mapped[,2:ncol(data_mapped)])) -> impute_out

cbind(data_mapped[,1],impute_out$ximp) %>% as_tibble() -> data_imputed

data_imputed %>% saveRDS('./data/processed/data_imputed.RDS')
