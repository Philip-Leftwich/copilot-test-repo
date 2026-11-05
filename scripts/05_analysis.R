# scripts/05_analysis.R: the original, trusted version ----
# Purpose: mean, standard deviation and number of animals for metabolic rate
# after treatment, by treatment arm and sex.
# Reads: scripts/04_load_data.R (object `voles`).
# Writes: the object `metabolic_summary` (no file). No manuscript location
# yet: add one here if the table is reported.
source(here::here("scripts", "00_packages.R"))
source(here::here("scripts", "04_load_data.R"))

# NA readings are not removed, so a group with a missing rate has an NA mean
# and sd
metabolic_summary <- voles |>
  dplyr::group_by(treatment_arm, sex) |>
  dplyr::summarise(
    mean_rate = mean(metabolic_rate_post),
    sd_rate   = sd(metabolic_rate_post),
    n         = dplyr::n(),
    .groups   = "drop"
  )
