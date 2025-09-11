#!/usr/bin/env Rscript

library(tidyverse)

read.csv('./data/raw/soep_practice_studv.csv') %>%
	as_tibble() -> data_raw

duplicated(data_raw) %>% sum() -> number_of_duplicates

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
		einkommenj2,
		einkommenm1,
		einkommenm2), as.double)) %>%
	select(
		-X,
		-weiblich,
		-gesund_org,
		-lebensz_org) -> data_clean

data_clean %>% saveRDS('./data/processed/data_clean.RDS')