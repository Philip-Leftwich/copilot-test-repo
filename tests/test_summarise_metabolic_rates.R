library(testthat)
library(here)
library(dplyr)

source(here::here("scripts", "functions", "summarise_metabolic_rates.R"))

# Load the human-captured reference fixture — treated as read-only ground truth.
reference <- readRDS(here::here("tests", "metabolic_summary.rds"))

# Load the same raw data the fixture was derived from.
voles <- readr::read_csv(
  here::here("data", "voles_metabolism.csv"),
  col_types = readr::cols(
    treatment_arm       = readr::col_character(),
    sex                 = readr::col_character(),
    metabolic_rate_post = readr::col_double()
  )
)

test_that("summarise_metabolic_rates output matches reference fixture", {
  result <- summarise_metabolic_rates(voles)

  # Sort both objects on the grouping keys (and mean_rate for determinism)
  # before comparison to neutralise any unspecified row order.
  sort_key <- c("treatment_arm", "sex")
  result    <- dplyr::arrange(result,    across(all_of(sort_key)))
  reference <- dplyr::arrange(reference, across(all_of(sort_key)))

  expect_equal(result, reference)
})

test_that("summarise_metabolic_rates rejects a non-data-frame input", {
  expect_error(summarise_metabolic_rates("not a data frame"))
})

test_that("summarise_metabolic_rates aborts when required columns are missing", {
  bad_df <- tibble::tibble(treatment_arm = "Control", sex = "F")
  expect_error(
    summarise_metabolic_rates(bad_df),
    class = "metabolic_summary_missing_columns"
  )
})
