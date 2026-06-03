# R/02_analysis.R — the original, trusted version
source(here::here("scripts", "01_load_data.R"))
source(here::here("scripts", "functions", "summarise_metabolic_rates.R"))

metabolic_summary <- summarise_metabolic_rates(voles)
