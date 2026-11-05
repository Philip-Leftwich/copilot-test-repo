##### tests/test_scripts.R #####
# Characterisation test for whole scripts. Re-runs each captured script in a
# fresh environment and compares every object it creates, and the checksums
# of the data files the scripts write, with the frozen reference captured by
# tests/make_reference.R. Use it for refactors and modernisation that span
# scripts (namespacing, pipes, superseded functions). It re-runs the whole
# analysis and rewrites its output files.
# Run from the project root, in a fresh R process:
#   Rscript -e "testthat::test_file(here::here('tests', 'test_scripts.R'))"

library(testthat)
testthat::local_edition(3)

reference <- readRDS(here::here("tests", "fixtures", "script_objects.rds"))

# Must match the capture script's run_script(), so both sides are produced
# the same way.
run_script <- function(script) {
  env <- new.env(parent = globalenv())
  source(here::here("scripts", script), local = env)
  as.list(env) |>
    purrr::discard(\(x) is.function(x) || inherits(x, c("gg", "ggplot")))
}

# Intermediate objects that a refactor has deliberately moved inside a
# function, so they no longer exist at script level. Every entry must be
# agreed in the plan, for example:
#   removed_by_plan <- list("05_analysis.R" = c("species_means"))
removed_by_plan <- list()

# Scripts run in the captured order, because later scripts read files that
# earlier ones write. New objects are allowed; every captured object not
# listed above must still exist, under the same name, unchanged.
purrr::iwalk(reference, \(expected, script) {
  test_that(paste(script, "reproduces every captured object"), {
    actual <- run_script(script)
    to_compare <- setdiff(names(expected), removed_by_plan[[script]])

    purrr::walk(to_compare, \(name) {
      expect_equal(
        actual[[name]],
        expected[[name]],
        label = paste0(script, ": ", name),
        expected.label = "the frozen reference"
      )
    })
  })
})

test_that("data files written by the scripts match their captured checksums", {
  checksums <- readr::read_csv(
    here::here("tests", "fixtures", "output_checksums.csv"),
    col_types = "cc"
  )

  expect_equal(
    unname(tools::md5sum(file.path(here::here(), checksums$file))),
    checksums$md5
  )
})
