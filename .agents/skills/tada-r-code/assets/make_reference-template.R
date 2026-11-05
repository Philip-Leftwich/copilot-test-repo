##### tests/make_reference.R #####
# Captures the frozen reference: every object each analysis script creates,
# and checksums of the data files the scripts write.
# Run once, from the project root, after the enabling changes are committed
# and before any refactoring:
#   Rscript tests/make_reference.R
# Then commit this script and everything it wrote to tests/fixtures/.
# It refuses to run if a reference already exists, so an accidental second
# run cannot overwrite it.

fixtures <- here::here("tests", "fixtures")

if (length(list.files(fixtures)) > 0) {
  stop(
    "tests/fixtures/ already holds a reference; it is never overwritten.",
    call. = FALSE
  )
}

dir.create(fixtures, recursive = TRUE, showWarnings = FALSE)

##### Scripts to capture, in run order #####
# Placeholder names: replace them with your scripts, in the order the README
# gives. Each runs in its own fresh environment, as in separate R sessions.
scripts <- c("01_clean_data.R", "02_fit_models.R", "05_analysis.R")

##### Run each script and keep its results #####
# Functions are dropped because they are code, not results. Plot objects are
# dropped because they carry whole environments; assign the data a figure
# plots to a named object instead, and that is captured.
run_script <- function(script) {
  env <- new.env(parent = globalenv())
  source(here::here("scripts", script), local = env)
  as.list(env) |>
    purrr::discard(\(x) is.function(x) || inherits(x, c("gg", "ggplot")))
}

# One second's margin for file systems that record whole seconds.
run_started <- Sys.time() - 1

script_objects <- scripts |>
  purrr::set_names() |>
  purrr::map(run_script)

saveRDS(script_objects, file.path(fixtures, "script_objects.rds"))

##### Checksums of the data files the scripts wrote #####
# Text data files only: the bytes of image files change with the graphics
# device and package versions. Files not rewritten by this run are skipped.
output_files <- list.files(
  c(here::here("output"), here::here("data", "processed")),
  pattern = "\\.(csv|tsv|txt)$",
  recursive = TRUE,
  full.names = TRUE
)

tibble::tibble(path = output_files) |>
  dplyr::filter(file.mtime(path) >= run_started) |>
  dplyr::mutate(
    file = sub(paste0(here::here(), "/"), "", path, fixed = TRUE),
    md5 = unname(tools::md5sum(path))
  ) |>
  dplyr::select(file, md5) |>
  readr::write_csv(file.path(fixtures, "output_checksums.csv"))

##### Record provenance #####
# Lets a later test failure be traced to a change of R or package version.
git_commit <- tryCatch(
  system2("git", c("rev-parse", "HEAD"), stdout = TRUE),
  error = function(e) "unavailable"
)

writeLines(
  c(
    paste("Captured:", format(Sys.time(), tz = "UTC", usetz = TRUE)),
    paste("Git commit:", git_commit),
    "",
    utils::capture.output(utils::sessionInfo())
  ),
  file.path(fixtures, "provenance.txt")
)

##### Make the reference read-only #####
# A guard against accidental edits on this machine; git is the record.
# On Windows this sets the read-only attribute.
fixture_files <- list.files(fixtures, full.names = TRUE)
Sys.chmod(fixture_files, mode = "0444")

message(
  "Wrote:\n",
  paste0("  ", basename(fixture_files), " (",
         format(file.size(fixture_files), big.mark = ","), " bytes)",
         collapse = "\n")
)
