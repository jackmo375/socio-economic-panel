#!/usr/bin/env bash

./scripts/clean.R

quarto render reports/report_clean.qmd

./scripts/transform.R

quarto render reports/report_transform.qmd

./scripts/impute.R

quarto render reports/report_impute.qmd

./scripts/model.R

