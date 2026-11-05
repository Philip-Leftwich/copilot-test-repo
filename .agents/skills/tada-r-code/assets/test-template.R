##### tests/test_summary_functions.R #####
# Characterisation test for scripts/functions/summary_functions.R.
# Compares summarise_metabolism() with the frozen reference captured from the
# original script by tests/make_reference.R. A pass shows the output is
# unchanged for this input, not that it is correct.
# Run from the project root, in a fresh R process:
#   Rscript -e "testthat::test_file(here::here('tests', 'test_summary_functions.R'))"
#
# Example names are placeholders: replace them with your own.

library(testthat)
testthat::local_edition(3)

source(here::here("scripts", "00_packages.R"))
source(here::here("scripts", "functions", "summary_functions.R"))

captured <- readRDS(here::here("tests", "fixtures", "script_objects.rds"))
# The input as the moved code received it. If the script overwrites this
# object later, use the copy kept by the enabling change instead.
input <- captured[["05_analysis.R"]][["metabolic_data"]]
reference <- captured[["05_analysis.R"]][["metabolic_summary"]]

test_that("summarise_metabolism() reproduces the frozen reference", {
  # Compared as is, including row order and grouping. Sort both sides only
  # if the plan records why row order can vary between runs.
  expect_equal(summarise_metabolism(input), reference)
})

test_that("the argument check names each missing required column", {
  # The required columns are part of the function's contract, written out
  # here deliberately: if the check omits one, this test fails.
  required <- c("species", "treatment", "metabolic_rate_w")

  purrr::walk(required, \(column) {
    without_column <- input |>
      dplyr::ungroup() |>
      dplyr::select(-dplyr::all_of(column))

    condition <- expect_error(
      summarise_metabolism(without_column),
      class = "missing_columns_error"
    )
    expect_equal(condition$missing_columns, column)
  })
})

test_that("the argument check rejects input that is not a data frame", {
  expect_error(
    summarise_metabolism(as.list(input)),
    class = "invalid_data_error"
  )
})
