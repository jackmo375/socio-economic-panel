#!/usr/bin/env Rscript

library(tidyverse)

readRDS('./data/processed/data_clean.RDS') -> data_clean

data_clean %>%
  mutate(
  	age = age/100,
    persons_in_household = log(persons_in_household),
    children_in_household = (children_in_household + 1)^(-1),
    number_of_years_of_education = log(number_of_years_of_education),
    total_annual_income = log(total_annual_income + 1),   # we add one to avoid negative infinities, as some incomes are zero
    general_health_status = 6 - general_health_status) -> data_transformed

data_transformed %>% saveRDS('./data/processed/data_transformed.RDS')
