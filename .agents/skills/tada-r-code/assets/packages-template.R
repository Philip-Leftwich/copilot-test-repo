##### scripts/00_packages.R #####
# Attaches every package the analysis uses. Sourced at the top of each script
# and each test, so all of them run with the same packages attached.
# dplyr functions, and the other known clashes listed in the skill's
# conventions, are still written with their namespace in the code.
#
# Placeholder list: replace it with the packages your scripts use.

library(dplyr)
library(tidyr)
library(readr)
library(purrr)
library(ggplot2)

# Optional safety net: turn any remaining clash between attached packages
# into an error instead of a silent switch, and record each choice.
# library(conflicted)
# conflicts_prefer(dplyr::filter, dplyr::lag, dplyr::select)
