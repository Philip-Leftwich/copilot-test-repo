# tests/test_summary_functions.R ----
library(testthat)
local_edition(3)
source(here::here("scripts", "functions", "load_voles.R"))
source(here::here("scripts", "functions", "summary_functions.R"))

test_that("summarise_metabolic_rate() reproduces the original summary", {
  reference <- readRDS(here::here("tests", "fixtures", "metabolic_summary.rds"))
  expect_equal(summarise_metabolic_rate(load_voles()), reference, tolerance = 1e-8)
})

test_that("summarise_metabolic_rate() rejects data without a required column", {
  no_rate <- dplyr::select(load_voles(), -metabolic_rate_post)
  expect_error(summarise_metabolic_rate(no_rate), "metabolic_rate_post")
})
