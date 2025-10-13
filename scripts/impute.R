#!/usr/bin/env Rscript

library(tidyverse)
library(missForest)

readRDS('./data/processed/data_transformed.RDS') -> data_transformed

missForest(as.data.frame(data_transformed[,2:ncol(data_transformed)]), variablewise = TRUE) -> impute_out
cbind(data_transformed[,1],impute_out$ximp) %>% as_tibble() -> data_imputed

data_imputed %>% saveRDS('./data/processed/data_imputed.RDS')
impute_out %>% saveRDS('./data/processed/impute_output.RDS')

# The imputation errors can then be visualized via:
#
# missForest_object$OOB_err %>% 
#   filter(!is.na(NMSE)) %>% 
#   ggplot(aes(iteration, NMSE, col = variable)) +
#   geom_point() +
#   geom_line()