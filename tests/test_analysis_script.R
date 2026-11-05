##### tests/test_analysis_script.R #####
# Characterisation test: scripts/05_analysis.R must reproduce the frozen
# reference captured by tests/make_reference.R, as is, including row order.
# Run from the project root in a fresh R process:
#   Rscript -e "testthat::test_file(here::here('tests', 'test_analysis_script.R'))"

library(testthat)
testthat::local_edition(3)

reference <- readRDS(here::here("tests", "fixtures", "metabolic_summary.rds"))

test_that("05_analysis.R reproduces the captured metabolic_summary", {
  env <- new.env(parent = globalenv())
  source(here::here("scripts", "05_analysis.R"), local = env)
  expect_equal(
    env$metabolic_summary,
    reference,
    expected.label = "the frozen reference"
  )
})
