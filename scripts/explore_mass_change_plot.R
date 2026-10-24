# scripts/explore_mass_change_plot.R ----
# Exploratory: change in body mass by treatment arm (Block 3).
library(tidyverse)
library(here)
source(here("scripts", "functions", "load_voles.R"))

voles <- load_voles() |>
  mutate(
    mass_change_g = mass_post_g - mass_pre_g,
    treatment_arm = factor(treatment_arm, levels = c("Control", "Low_dose", "High_dose"))
  )

mass_change_plot <- ggplot(voles, aes(x = treatment_arm, y = mass_change_g)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.15, height = 0, alpha = 0.6) +
  labs(x = "Treatment arm", y = "Change in body mass (g)")

ggsave(
  here("outputs", "mass_change_by_arm.png"),
  mass_change_plot,
  width = 6, height = 4, dpi = 300
)
