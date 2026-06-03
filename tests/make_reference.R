# tests/fixtures/make_reference.R
# Run this BEFORE refactoring, and capture only once.
source(here::here("scripts", "02_analysis.R"))
saveRDS(
  metabolic_summary,
  here::here("tests","metabolic_summary.rds")
)