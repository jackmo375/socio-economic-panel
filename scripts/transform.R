#!/usr/bin/env Rscript

library(tidyverse)

readRDS('./data/processed/data_clean.RDS') -> data_clean

data_clean %>%
	mutate(
		alter = alter^(1/3),
		anz_pers = anz_pers^(1/3),
		kinder = ifelse(anz_kind==0, FALSE, TRUE),
		anz_kind = anz_kind^(1/3),
		bildung = bildung^(1/3),
		einkommenj1_nonzero = ifelse(einkommenj1==0, TRUE, FALSE),
		einkommenj2_nonzero = ifelse(einkommenj2==0, TRUE, FALSE),
		number_nonzero_income_sources = einkommenj1_nonzero + einkommenj1_nonzero,
		total_income = (einkommenj1 + einkommenj2)^(1/3),
		gesund_num = (6 - gesund_num)^(1/3),
		lebensz_num = lebensz_num^(1/3)) %>%
	mutate(across(c(
		kinder), as.factor)) %>%
	select(
		id,
		sex,
		alter,
		anz_pers,
		kinder,
		bildung,
		erwerb,
		total_income,
		number_nonzero_income_sources,
		gesund_num,
		lebensz_num) -> data_mapped

data_mapped %>% saveRDS('./data/processed/data_mapped.RDS')

