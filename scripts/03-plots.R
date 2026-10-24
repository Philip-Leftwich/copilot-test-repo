source(here::here("scripts", "01_load_data.R"))

# Audience not specified; defaulting to journal-lab-report.
# Variables: treatment_arm (discrete, 3 unordered groups), mass_post_g (continuous, g).
# Chart type: raincloud (stat_halfeye + boxplot + jitter); n = 24 per group, all points shown.
# Statistical annotations: no model object in session; omitted.

library(ggplot2)
library(ggdist)
library(colorspace)
library(here)
library(ragg)

fig1 <- ggplot(voles, aes(x = treatment_arm, y = mass_post_g,
                           colour = treatment_arm, shape = treatment_arm)) +
  ggdist::stat_halfeye(
    aes(fill = treatment_arm),
    adjust = 0.6, width = 0.5, justification = -0.25,
    .width = 0, point_colour = NA, alpha = 0.4
  ) +
  geom_boxplot(width = 0.12, outlier.shape = NA, alpha = 0.6, colour = "grey30") +
  geom_point(
    position = position_jitter(width = 0.05, seed = 3819),
    alpha = 0.6, size = 1.8
  ) +
  colorspace::scale_colour_discrete_qualitative(palette = "Dark 2", guide = "none") +
  colorspace::scale_fill_discrete_qualitative(palette = "Dark 2", guide = "none") +
  scale_shape_discrete(guide = "none") +
  labs(
    x = "Treatment arm",
    y = "Post-treatment body mass (g)"
  ) +
  theme_project()

fig1

dir.create(here::here("outputs", "figures"), recursive = TRUE, showWarnings = FALSE)


library(patchwork)

# Panel B: counts of voles per treatment arm
# The count bar chart encodes the grouping variable on the y-axis (no fill/colour needed
# for a simple count; fill added for visual consistency with panel A).
fig2 <- ggplot(voles, aes(y = treatment_arm, fill = treatment_arm)) +
  geom_bar() +
  colorspace::scale_fill_discrete_qualitative(palette = "Dark 2", name = "Treatment arm") +
  scale_x_continuous(breaks = scales::breaks_width(4), expand = expansion(mult = c(0, 0.05))) +
  labs(x = "Count", y = "Treatment arm") +
  theme_project() +
  guides(fill = "none")

# Composite: fig1_annotated is the legend-bearer (richest encoding: colour + shape + fill)
# fig2 suppresses its fill guide so only one legend is emitted.
fig_combined <- fig1_annotated +
  guides(
    colour = guide_legend(title = "Treatment arm"),
    shape  = guide_legend(title = "Treatment arm"),
    fill   = guide_legend(title = "Treatment arm")
  ) +
  fig2 +
  patchwork::plot_layout(guides = "collect") +
  patchwork::plot_annotation(tag_levels = "A") &
  theme(legend.position = "bottom",
        plot.tag = element_text(face = "bold", size = 12))

fig_combined

ggsave(here::here("outputs", "figures", "mass_post_combined.pdf"),
       plot = fig_combined, width = 180, height = 105, units = "mm")

ggsave(here::here("outputs", "figures", "mass_post_combined.png"),
       plot = fig_combined, width = 180, height = 105, units = "mm", dpi = 300,
       device = ragg::agg_png, bg = "white")

