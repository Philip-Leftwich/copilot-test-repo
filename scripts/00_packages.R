##### scripts/00_packages.R #####
# Attaches every package the analysis scripts use. Sourced at the top of each
# script and test so that all of them run with the same packages attached.
# dplyr functions are still written with their namespace in the code.

library(dplyr)
library(readr)
