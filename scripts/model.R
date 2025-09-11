#!/usr/bin/env Rscript

library(tidyverse)
library(lattice)
library(Matrix)
library(lme4)

readRDS('./data/processed/data_imputed.RDS') -> data_imputed

lme.fit <- lmer(
	lebensz_num ~ (1|id) + sex + alter + anz_pers + kinder + bildung + erwerb + total_income + number_nonzero_income_sources + gesund_num,
	data=data_imputed)
summary(lme.fit)
residuals(lme.fit) %>% hist

lme.fit %>% saveRDS('./results/model.RDS')
coef(summary(lme.fit)) %>% write.csv('./results/fixed_effects.csv')



expand.grid(ID, SEX, ALTER, ANZ_PERS, KINDER, BILDUNG, ERWERB, TOTAL_INCOME, NUMBER_NONZERO_INCOME_SOURCES, GESUND_NUM)
