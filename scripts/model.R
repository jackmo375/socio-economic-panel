#!/usr/bin/env Rscript

library(tidyverse)
library(lme4)

readRDS('./data/processed/data_imputed.RDS') -> data_imputed

lmer(
	formula=life_satisfaction ~ 
		(1|id) + 
		sex + 
		age + I(age^2) + 
		persons_in_household +
		children_in_household + 
		number_of_years_of_education + 
		employment_status + 
		number_income_sources + 
		total_annual_income +
		general_health_status,
	data=data_imputed) -> lme_fit

lme_fit %>% saveRDS('./results/lme_fit.RDS')