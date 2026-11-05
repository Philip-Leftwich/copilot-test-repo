# scripts/04_load_data.R ----
# Purpose: read the voles data into the object `voles`.
# Reads: data/raw/voles_metabolism.csv (via load_voles()). Writes: nothing.
# Runs before: scripts/05_analysis.R, which sources this script.
source(here::here("scripts", "00_packages.R"))
source(here::here("scripts", "functions", "load_voles.R"))

voles <- load_voles()
