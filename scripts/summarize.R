#!/usr/bin/env Rscript

#
#	this should be an Rmarkdown report really
#

library(tidyverse)

readRDS('./data/data_clean.RDS') -> data_clean

data_clean %>% glimpse

# 23522 observations
# 15 variables

# "id"          "syear"       "sex"         "alter"       "anz_pers"   
# "anz_kind"    "bildung"     "erwerb"      "branche"     "einkommenj1"
# "einkommenj2" "einkommenm1" "einkommenm2" "lebensz_num" "gesund_num" 

### explanatory variables

## syear
# integer, time
data_clean %>% group_by(syear) %>% summarise(count = n())
data_clean %>% ggplot(aes(x=syear)) + geom_histogram()

## sex
# nominal, 2 categories
data_clean %>% group_by(sex) %>% summarise(count = n()) # most common: "weiblich"
data_clean %>% ggplot(aes(y=sex)) + geom_bar() + facet_wrap(~ syear)

## alter
# integer
data_clean$alter %>% fivenum # 17  34  48  62 102
data_clean %>% ggplot(aes(x=alter)) + geom_histogram(bins=15) + facet_wrap(~ syear) # not normal: right-skewed, irregular/multimodal
data_clean %>% ggplot(aes(x=alter^(1/3))) + geom_histogram(bins=20) + facet_wrap(~ syear) # alter is not unimodal! (why?)

## anz_pers
# integer
data_clean$anz_pers %>% is.na() %>% sum() # 77 missing records
data_clean$anz_pers %>% fivenum #  1  2  2  4 13
data_clean %>% ggplot(aes(x=anz_pers)) + geom_bar() + facet_wrap(~ syear) # data highly non-normal, right-skewed
data_clean %>% ggplot(aes(x=anz_pers^(1/3))) + geom_histogram(bins=8)


## anz_kind
#m integer
data_clean$anz_kind %>% is.na() %>% sum() # 77 missing records
data_clean$anz_kind %>% fivenum() # 0  0  0  1 10
data_clean %>% ggplot(aes(x=anz_kind)) + geom_bar()  + facet_wrap(~ syear) # data non-normal: right skewed and zero-inflated

# bildung
# double
data_clean$bildung %>% is.na() %>% sum() # 1611 records with missing values
data_clean$bildung %>% fivenum # 7.0 10.5 11.5 14.0 18.0
data_clean %>% ggplot(aes(x=bildung)) + geom_histogram(bins=10) + facet_wrap(~ syear) # data is highly non-normal / irregular/multimodal,
	# 3 peaks at ~ 7, 10, 18 (I suppose this is graduating: school, university, phd? it doesnt match the 9 required years in Germany...)

# erwerb
# nominal, 6 categories
data_clean$erwerb %>% is.na() %>% sum() # 2 missing
data_clean %>% group_by(erwerb) %>% summarise(count=n()) # most common: "[5] Nicht erwerbstätig", least common: "Werkstatt für behinderte Menschen" (29)
data_clean %>% ggplot(aes(y=erwerb)) + geom_bar()  + facet_wrap(~ syear)

# branche
data_clean$branche %>% unique %>% length # nominal, 84 categories
data_clean$branche %>% is.na() %>% sum() # 9936 missing

# einkommenj1
# double
data_clean$einkommenj1 %>% is.na() %>% sum() # 0 missing records
data_clean$einkommenj1 %>% fivenum() #  0.000      0.000   5786.075  28524.809 269424.940
data_clean %>% ggplot(aes(x=einkommenj1)) + geom_histogram() + facet_wrap(~ syear) # not normal, highly zero-inflated
data_clean %>% ggplot(aes(x=einkommenj1^(1/3))) + geom_histogram()

# einkommenm1
# double
data_clean$einkommenm1 %>% is.na() %>% sum() # 0 missing records
data_clean$einkommenm1 %>% fivenum() #  0.0000     0.0000   852.9226  2687.4824 35260.9140
data_clean %>% ggplot(aes(x=einkommenm1)) + geom_histogram() + facet_wrap(~ syear) # not normal, highly zero-inflated

# einkommenj2
# double
data_clean$einkommenj2 %>% is.na() %>% sum() # 0 missing records
data_clean$einkommenj2 %>% fivenum() #  0.00     0.00     0.00     0.00 79179.91
data_clean %>% ggplot(aes(x=einkommenj2)) + geom_histogram() + facet_wrap(~ syear) # not normal, **highly** zero-inflated

# einkommenm2
# double
data_clean$einkommenm2 %>% is.na() %>% sum() # 0 missing records
data_clean$einkommenm2 %>% fivenum() #  0.00     0.00     0.00     0.00 12033.17
data_clean %>% ggplot(aes(x=einkommenm2)) + geom_histogram() + facet_wrap(~ syear) # not normal, **highly** zero-inflated

# gesund_num
# integer (likert)
data_clean$gesund_num %>% is.na() %>% sum() # 102 records missing
data_clean$gesund_num %>% fivenum() # 1 2 2 3 5
data_clean %>% ggplot(aes(x=gesund_num)) + geom_bar()  + facet_wrap(~ syear) # looks a bit normal? slightly right skewed

### dependent variable

# lebensz_num
# integer (likert)
data_clean$lebensz_num %>% is.na() %>% sum() # 611 missing records
data_clean$lebensz_num %>% fivenum() # 0  7  8  8 10
data_clean %>% ggplot(aes(x=lebensz_num)) + geom_bar()  + facet_wrap(~ syear) # not normal, skewed left
