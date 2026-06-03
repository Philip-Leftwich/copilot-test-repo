# R/02_analysis.R — the original, trusted version
source(here::here("scripts", "01_load_data.R"))

metabolic_summary <- voles |>
  group_by(treatment_arm, sex) |>
  summarise(
    mean_rate = mean(metabolic_rate_post),
    sd_rate   = sd(metabolic_rate_post),
    n         = n(),
    .groups   = "drop"
  )