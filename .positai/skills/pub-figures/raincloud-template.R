# raincloud-template.R
# Figure skeleton: raincloud for Discrete x Continuous.
# Audience not specified; defaulting to journal-lab-report.
# Re-run with explicit audience if poster, talk, or public-engagement intended.

library(ggplot2)
library(ggdist)
library(ggbeeswarm)
library(colorspace)
library(here)
library(scales)


source(here::here("R", "theme-project.R"))

# data |> expects: group (factor), value (numeric)
fig1 <-
  data |>
  ggplot(aes(x = group, y = value, colour = group, shape = group)) +
  ggdist::stat_halfeye(
    aes(fill = group),
    adjust = 0.5, width = 0.6, justification = -0.2,
    .width = 0, point_colour = NA, alpha = 0.5
  ) +
  geom_boxplot(width = 0.12, outlier.shape = NA, alpha = 0.5) +
  geom_point(
    position = position_jitter(width = 0.05, seed = 1),
    alpha = 0.4, size = 1.5
  ) +
  colorspace::scale_colour_discrete_qualitative(palette = "Dark 2") +
  colorspace::scale_fill_discrete_qualitative(palette = "Dark 2") +
  scale_shape_discrete() + # redundant encoding alongside colour
  labs(x = NULL, y = "Value (unit)") +
  theme_project()

# Accessibility check; investigator to run and inspect.
colorBlindness::cvdPlot(fig1)