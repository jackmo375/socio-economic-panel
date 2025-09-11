#!/usr/bin/env Rscript

library(tidyverse)
library(lattice)
library(Matrix)
library(lme4)

readRDS('./results/model.RDS') -> lme.fit
readRDS('./data/processed/data_imputed.RDS') -> data_imputed

# do outlier stuff here
stdev <- var(residuals(lme.fit))^(1/2)

residuals(lme.fit) -> data_imputed$residuals
residuals(lme.fit) >= stdev -> data_imputed$outlier