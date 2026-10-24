# scripts/05_analysis.R: after refactoring ----
library(tidyverse)
library(here)
source(here("scripts", "04_load_data.R"))
source(here("scripts", "functions", "summary_functions.R"))

metabolic_summary <- summarise_metabolic_rate(voles)
