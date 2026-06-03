library(testthat)
library(here)

source(here::here("scripts", "01_load_data.R"))
source(here::here("scripts", "functions", "summarise_metabolic_rates.R"))

reference_summary <- readRDS(here::here("tests", "metabolic_summary.rds"))

test_that("summarise_metabolic_rates matches the reference fixture", {
  actual_summary <- summarise_metabolic_rates(voles)

  actual_sorted <- dplyr::arrange(actual_summary, treatment_arm, sex)
  reference_sorted <- dplyr::arrange(reference_summary, treatment_arm, sex)

  expect_equal(actual_sorted, reference_sorted)
})
