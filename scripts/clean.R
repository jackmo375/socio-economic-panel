#!/usr/bin/env Rscript

library(tidyverse)

read.csv('./data/raw/soep_practice_studv.csv') %>%
	as_tibble() -> data_raw

data_raw %>% 
  mutate_if(is.character, ~na_if(., '')) %>%
  mutate(across(c(
    id,
    sex,
    erwerb,
    branche), as.factor)) %>%
  mutate(across(c(
    syear,
    alter,
    anz_pers,
    anz_kind,
    lebensz_num,
    gesund_num), as.integer)) %>%
  mutate(across(c(
    bildung,
    einkommenj1,
    einkommenj2), as.double)) %>%
  rename(
    study_year = syear,
    age = alter,
    persons_in_household = anz_pers,
    children_in_household = anz_kind,
    number_of_years_of_education= bildung,
    employment_status = erwerb,
    general_health_status = gesund_num,
    life_satisfaction = lebensz_num) %>%
  mutate(
    sex = fct_recode(sex,
      "female" = "[1] weiblich",
      "male" = "[0] männlich"),
    employment_status = fct_recode(employment_status,
      "part_time" = "[2] Teilzeitbeschäftigung",
      "unemployed" = "[5] Nicht erwerbstätig",
      "full_time" = "[1] Voll erwerbstätig",
      "irregular_marginal" = "[4] Unregelmässig, geringfügig erwerbstät.",
      "education_apprenticeship" = "[3] Ausbildung, Lehre",
      "workshop_for_disabled_people" = "[6] Werkstatt für behinderte Menschen"),
    einkommenj1_nonzero = ifelse(einkommenj1==0, TRUE, FALSE),
    einkommenj2_nonzero = ifelse(einkommenj2==0, TRUE, FALSE),
    number_income_sources = einkommenj1_nonzero + einkommenj2_nonzero,
    total_annual_income = einkommenj1 + einkommenj2) %>%
  select(
    id,
    study_year,
    sex, 
    age,
    persons_in_household,
    children_in_household,
    number_of_years_of_education,
    employment_status,
    number_income_sources,
    total_annual_income,
    general_health_status,
    life_satisfaction) -> data_clean

data_clean %>% saveRDS('./data/processed/data_clean.RDS')