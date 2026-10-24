# scripts/fig_house.R ----
# Post-treatment body mass by treatment arm, in the house figure style
# (.agents/skills/house-figures), for a lab report (Block 4).
library(tidyverse)
library(here)
source(here("scripts", "functions", "load_voles.R"))

arm_levels <- c("Control", "Low_dose", "High_dose")

voles <- load_voles() |>
  mutate(treatment_arm = factor(treatment_arm, levels = arm_levels))

# mean and standard deviation per arm, with the number of animals behind each
mass_summary <- voles |>
  summarise(
    mean_mass = mean(mass_post_g),
    sd_mass = sd(mass_post_g),
    n = n(),
    .by = treatment_arm
  )

# Okabe-Ito, skipping its first colour (black) so the points stand out from
# the summary
arm_colours <- set_names(
  unname(grDevices::palette.colors(palette = "Okabe-Ito"))[2:4],
  arm_levels
)

fig_house <- ggplot(voles, aes(x = treatment_arm, y = mass_post_g)) +
  # every animal, since each arm has fewer than 30
  geom_jitter(
    aes(colour = treatment_arm, shape = treatment_arm),
    width = 0.15, height = 0, size = 2, alpha = 0.8
  ) +
  # the summary overlaid: mean plus or minus one standard deviation
  geom_pointrange(
    data = mass_summary,
    aes(y = mean_mass, ymin = mean_mass - sd_mass, ymax = mean_mass + sd_mass),
    position = position_nudge(x = 0.3)
  ) +
  geom_text(
    data = mass_summary,
    aes(y = -Inf, label = paste0("n = ", n)),
    vjust = -0.5
  ) +
  scale_colour_manual(values = arm_colours) +
  # extra room at the bottom for the n labels
  scale_y_continuous(expand = expansion(mult = c(0.12, 0.05))) +
  labs(
    x = "Treatment arm",
    y = "Body mass after treatment (g)",
    caption = "Points: individual animals. Black: mean ± 1 SD."
  ) +
  theme_classic(base_size = 12) +
  theme(legend.position = "none")

ggsave(
  here("outputs", "fig_house_mass_post.png"),
  fig_house,
  width = 6, height = 4.5, dpi = 300
)
